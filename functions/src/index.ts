import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import {FieldValue} from 'firebase-admin/firestore';
import {DecodedIdToken} from 'firebase-admin/lib/auth/token-verifier';

admin.initializeApp();

const firestore = admin.firestore();
const fcm = admin.messaging();

export const sendToTopic = functions.firestore.document('puppies/{puppyId}').onCreate(async (snapshot) => {
  const puppy = snapshot.data();
  const payload: admin.messaging.MessagingPayload = {
    notification: {
      title: 'New Puppy!',
      body: `${puppy.name} is ready for adoption`,
      icon: 'your-icon-url',
      clickAction: 'FLUTTER_NOTIFICATION_CLICK',
    },
  };

  return fcm.sendToTopic('puppies', payload);
});

export const sendToDevice = functions.firestore.document('orders/{orderId}').onCreate(async (snapshot) => {
  const order = snapshot.data();
  const querySnapshot = await firestore.collection('users').doc(order.seller).collection('tokens').get();

  const tokens = querySnapshot.docs.map((snap) => snap.id);

  functions.logger.log('tokens');
  functions.logger.log(tokens);
  functions.logger.log('end tokens');

  // add deeplink with right path which go router understands
  const payload: admin.messaging.MessagingPayload = {
    notification: {
      title: 'New Order!',
      body: `you sold a ${order.product} for ${order.total}`,
      icon: 'your-icon-url',
      // clickAction: 'FLUTTER_NOTIFICATION_CLICK',
    },
  };
  return fcm.sendToDevice(tokens, payload);
});

exports.saveDeviceToken = functions.region('europe-west3').https.onCall(async (data, context) => {
  const now = admin.firestore.Timestamp.fromDate(new Date());
  const deviceToken = data.deviceToken;
  const platform = data.platform;

  context.auth?.token;
  functions.logger.log('context.auth?.token\n');
  functions.logger.log(context.auth?.token);
  functions.logger.log('context.auth?.uid\n');
  functions.logger.log(context.auth?.uid);

  if (!context.auth) {
    throw new functions.https.HttpsError('failed-precondition', 'The function must be called while authenticated.');
  } else if (!context.auth.uid) {
    throw new functions.https.HttpsError('failed-precondition', 'The function could not retrieve uid');
  }

  // const currentUserUid = data.uid;

  functions.logger.log('data.uid\n');
  functions.logger.log(data.uid);
  const currentUserUid = context.auth?.uid;

  const docSnapshot = await admin
    .firestore()
    .collection('users')
    .doc(currentUserUid)
    .collection('tokens')
    .doc(deviceToken)
    .get();

  if (!docSnapshot.exists) {
    await admin
      .firestore()
      .collection('users')
      .doc(currentUserUid)
      .collection('tokens')
      .doc(deviceToken)
      .set({createdAt: now, platform, token: deviceToken});

    // Send back a message that we've successfully written the message
    return `Token with ID: ${deviceToken} successfully created.`;
  } else {
    return 'Token already exists';
  }
});

exports.deleteDeviceToken = functions.region('europe-west3').https.onCall(async (data) => {
  const deviceToken = data.deviceToken;
  const userIdToekn = data.idToken;

  const decodedIdToken: DecodedIdToken = await admin.auth().verifyIdToken(userIdToekn);
  const userUid = decodedIdToken.uid;

  const docSnapshot = await admin
    .firestore()
    .collection('users')
    .doc(userUid)
    .collection('tokens')
    .doc(deviceToken)
    .get();

  if (docSnapshot.exists) {
    await admin.firestore().collection('users').doc(userUid).collection('tokens').doc(deviceToken).delete();

    // Send back a message that we've successfully written the message
    return `Token with ID: ${deviceToken} successfully deleted.`;
  } else {
    return 'Token does not exist';
  }
});

export const followUser = functions.region('europe-west3').https.onCall(async (data) => {
  const followerUid = data.followerUid;
  const targetUid = data.targetUid;
  const followerUsername = data.followerUsername;

  functions.logger.log('data.targetUid', data.targetUid);
  functions.logger.log('data.followerUid', data.followerUid);

  const results = await Promise.all([
    await admin
      .firestore()
      .collection('users')
      .doc(targetUid)
      .update({followers: FieldValue.arrayUnion(followerUid)}),

    await admin
      .firestore()
      .collection('users')
      .doc(followerUid)
      .update({followings: FieldValue.arrayUnion(targetUid)}),
    await firestore.collection('users').doc(targetUid).collection('tokens').get(),
  ]);

  const querySnapshot = results[2];

  const tokens = querySnapshot.docs.map((snap) => snap.id);

  const payload: admin.messaging.MessagingPayload = {
    notification: {
      title: 'You have a new follower',
      body: `${followerUsername} started following you`,
      // icon: 'your-icon-url',
      // clickAction: 'FLUTTER_NOTIFICATION_CLICK',
    },
  };

  return fcm.sendToDevice(tokens, payload);
});

export const unfollowUser = functions.region('europe-west3').https.onCall(async (data) => {
  const followerUid = data.followerUid;
  const targetUid = data.targetUid;

  await admin
    .firestore()
    .collection('users')
    .doc(targetUid)
    .update({followers: FieldValue.arrayRemove(followerUid)});

  await admin
    .firestore()
    .collection('users')
    .doc(followerUid)
    .update({followings: FieldValue.arrayRemove(targetUid)});

  return true;
});

export const createUserData = functions.region('europe-west3').https.onCall(async (data) => {
  await admin.firestore().collection('users').doc(data.uid).set({
    followers: [],
    followings: [],
    uid: data.uid,
    username: data.displayName,
  });
});

// export const onUserCreated = functions
//   .region('europe-west3')
//   .auth.user()
//   .onCreate(async (user) => {
//     await admin.firestore().collection('users').doc(user.uid).set({
//       followers: [],
//       followings: [],
//       uid: user.uid,
//       username: user.displayName,
//     });
//   });
