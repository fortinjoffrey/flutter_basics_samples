import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

export const createMessage = functions.region('europe-west3').https.onCall(async (data) => {
  const original = data.text;

  const writeResult = await admin.firestore().collection('messages').add({original: original});

  return {result: `Message with ID: ${writeResult.id} added.`};
});
