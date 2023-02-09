import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import {FieldValue} from 'firebase-admin/firestore';
import {DecodedIdToken} from 'firebase-admin/auth';

const logger = functions.logger;

export const migrateDataFromAnonymousPermanent = functions
  .region('europe-west3')
  .https.onCall(async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError('failed-precondition', 'The function must be called while authenticated.');
    } else {
      logger.log('Received data: %j', data);

      const verifiedAnonymousIdToken = await verifyAnonymousUserIdToken(data.idToken);
      const permanentAccountIdToken = await verifyPermanentUserIdToken(context.auth.token);
      return performMigration(verifiedAnonymousIdToken, permanentAccountIdToken);
    }
  });

const isAnonymous = (idToken: DecodedIdToken) => {
  return idToken.firebase.sign_in_provider === 'anonymous';
};

async function verifyAnonymousUserIdToken(anonymousIdToken: string) {
  logger.log(`Verifying anonymous ID token ${anonymousIdToken}`);
  const verifiedAnonymousIdToken = await admin.auth().verifyIdToken(anonymousIdToken);

  if (!isAnonymous(verifiedAnonymousIdToken)) {
    throw new functions.https.HttpsError('invalid-argument', 'ID token must be anonymous', verifiedAnonymousIdToken);
  }
  return verifiedAnonymousIdToken;
}

async function verifyPermanentUserIdToken(permanentAccountIdToken: DecodedIdToken) {
  logger.log(`Verifying permanent ID token ${permanentAccountIdToken}`);

  if (isAnonymous(permanentAccountIdToken)) {
    throw new functions.https.HttpsError('invalid-argument', 'ID token must be non-anonymous', permanentAccountIdToken);
  }

  const gracePeriod = 5 * 60 * 1000;
  const authTime = permanentAccountIdToken.auth_time * 1000;
  const timeSinceSignIn = Date.now() - authTime;

  if (timeSinceSignIn > gracePeriod) {
    throw new functions.https.HttpsError(
      'invalid-argument',
      'This operation requires a recent sign-in.',
      permanentAccountIdToken
    );
  }

  return permanentAccountIdToken;
}

async function getQueryForAnonymousAuthorEvents(anonymousUserId: string) {
  const authorIdQuery = admin.firestore().collection('polls').where('authorId', '==', anonymousUserId);
  return authorIdQuery;
}

async function getQueryForAnonymousInvitedEvents(anonymousUserId: string) {
  const invitedUserIdsQuery = admin
    .firestore()
    .collection('polls')
    .where('invitedUserIds', 'array-contains', anonymousUserId);
  return invitedUserIdsQuery;
}

async function getQueryForAnonymousResponses(anonymousUserId: string, docId: string) {
  const responsesQuery = admin
    .firestore()
    .collection('polls')
    .doc(docId)
    .collection('responses')
    .where('user.id', '==', anonymousUserId);
  return responsesQuery;
}

async function updateUserIdForAuthoredEvents(
  transaction: admin.firestore.Transaction,
  querySnapshot: admin.firestore.QuerySnapshot<admin.firestore.DocumentData>,
  anonymousUserId: string,
  permamentUserId: string
) {
  if (querySnapshot.empty) {
    logger.log(`Previous user [${anonymousUserId}] didn't have any documents as author, nothing to do.`);
  } else {
    logger.log(
      `Migrating ${querySnapshot.size} author documents from userID [${anonymousUserId}] 
      to new userId [${permamentUserId}]`
    );
    querySnapshot.forEach((doc) => {
      transaction.update(doc.ref, {authorId: permamentUserId});
    });
  }
}

async function updateUserIdForInvitedEvents(
  transaction: admin.firestore.Transaction,
  querySnapshot: admin.firestore.QuerySnapshot<admin.firestore.DocumentData>,
  anonymousUserId: string,
  permamentUserId: string
) {
  if (querySnapshot.empty) {
    logger.log(`Previous user [${anonymousUserId}] didn't have any documents, nothing to do.`);
  } else {
    logger.log(
      `Migrating ${querySnapshot.size} posts from userID [${anonymousUserId}] 
      to new userId [${permamentUserId}]`
    );
    querySnapshot.forEach((doc) => {
      transaction.update(doc.ref, {
        invitedUserIds: FieldValue.arrayUnion(permamentUserId),
      });
      transaction.update(doc.ref, {
        invitedUserIds: FieldValue.arrayRemove(anonymousUserId),
      });
    });
  }
}

async function performMigration(anonymousIdToken: DecodedIdToken, permanentAccountIdToken: DecodedIdToken) {
  const anonymousUserId = anonymousIdToken.uid;
  const permamentUserId = permanentAccountIdToken.uid;

  logger.log(`Migrating tasks from previous userID [${anonymousUserId}] to new userID [${permamentUserId}].`);

  return admin.firestore().runTransaction(async (transaction) => {
    // 1.1 - Fetch all documents where user is the author
    const authorIdQuery = await getQueryForAnonymousAuthorEvents(anonymousUserId);
    const authorQuerySnapshot = await transaction.get(authorIdQuery);
    // 2.1 - Fetch all documents where user is invited
    const invitedUserIdsQuery = await getQueryForAnonymousInvitedEvents(anonymousUserId);
    const invitedQuerySnapshot = await transaction.get(invitedUserIdsQuery);
    const responsesQuerySnapshots: admin.firestore.QuerySnapshot<admin.firestore.DocumentData>[] = [];
    // 3.1 - Fetch all users responses
    for (let i = 0; i < invitedQuerySnapshot.docs.length; i++) {
      const doc = invitedQuerySnapshot.docs[i];
      logger.log(doc.data());

      const responsesQuery = await getQueryForAnonymousResponses(anonymousUserId, doc.id);

      const responsesQuerySnapshot = await transaction.get(responsesQuery);
      responsesQuerySnapshots.push(responsesQuerySnapshot);
    }

    // 1.2 - Update anonymous user documents as author with permanent id
    updateUserIdForAuthoredEvents(transaction, authorQuerySnapshot, anonymousUserId, permamentUserId);

    // 2.2 - Update anonymous user documents as author with permanent id
    updateUserIdForInvitedEvents(transaction, invitedQuerySnapshot, anonymousUserId, permamentUserId);

    // 3.2 - Update anonymous user responses with permanent id
    if (!(responsesQuerySnapshots.length == 0)) {
      responsesQuerySnapshots.forEach((response) => {
        response.docs.forEach((doc) => {
          transaction.update(doc.ref, {'user.id': permamentUserId});
        });
      });
    }

    return {
      updatedDocCount: authorQuerySnapshot.size + invitedQuerySnapshot.size,
    };
  });
}
