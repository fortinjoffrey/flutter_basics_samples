import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

export const migrateExistingPollToPollWithCreatedDate = functions.region('europe-west3').https.onRequest(async () => {
  const now = admin.firestore.Timestamp.fromDate(new Date());

  const createdAt = now;
  const lastUpdatedAt = now;

  const pollsQuery = await admin.firestore().collection('polls').get();

  return admin.firestore().runTransaction(async (transaction) => {
    pollsQuery.forEach((doc) => {
      transaction.update(doc.ref, {createdAt, lastUpdatedAt});
    });
  });
});
