import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

export const updateLastUpdatedDateOnPollUpdated = functions
  .region('europe-west3')
  .firestore.document('/polls/{documentId}')
  .onUpdate((snap) => {
    const firestore = admin.firestore;
    const now = firestore.Timestamp.fromDate(new Date());
    functions.logger.log('before: ', snap.before.data().lastUpdatedAt);
    functions.logger.log('after: ', snap.after.data().lastUpdatedAt);

    const lastUpdate = snap.after.data().lastUpdatedAt;

    const gracePeriod = 60 * 1000;
    const timeSinceSignLastUpdate = now.toMillis() - (lastUpdate?.toMillis() ?? 0);

    if (timeSinceSignLastUpdate < gracePeriod) {
      functions.logger.log('if (timeSinceSignLastUpdate < 60 seconds)');
      return;
    }

    snap.after.ref.update({
      lastUpdatedAt: now,
    });
  });
