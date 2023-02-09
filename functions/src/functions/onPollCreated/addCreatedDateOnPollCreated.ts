import * as functions from 'firebase-functions';
// import * as admin from 'firebase-admin';
import {FieldValue} from 'firebase-admin/firestore';

export const addCreatedDateOnPollCreated = functions
  .region('europe-west3')
  .firestore.document('/polls/{documentId}')
  .onCreate((snap) => {
    // const now = admin.firestore.Timestamp.fromDate(new Date());
    const now = FieldValue.serverTimestamp();
    // const now = admin.firestore.Timestamp.fromDate(new Date());

    const createdAt = now;
    const lastUpdatedAt = now;

    return snap.ref.set({createdAt, lastUpdatedAt}, {merge: true});
  });
