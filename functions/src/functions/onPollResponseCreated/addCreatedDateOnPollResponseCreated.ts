import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

export const addCreatedDateOnPollResponseCreated = functions
  .region('europe-west3')
  .firestore.document('/polls/{pollId}/responses/{responseId}')
  .onCreate(async (snap) => {
    const now = admin.firestore.Timestamp.fromDate(new Date());
    const t = snap.ref.parent.parent;
    functions.logger.log('t.id: ', t?.id);
    const d = await t?.get();
    functions.logger.log('d?.data() ', d?.data());

    functions.logger.log('snap.data(): ', snap.data());

    const createdAt = now;
    const lastUpdatedAt = now;

    return snap.ref.set({createdAt, lastUpdatedAt}, {merge: true});
  });
