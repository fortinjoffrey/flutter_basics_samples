import * as functions from 'firebase-functions';

export const makeOriginalPropertyForMessageUppercase = functions.firestore
  .document('/messages/{documentId}')
  .onCreate((snap, context) => {
    const original = snap.data().original;

    functions.logger.log('Uppercasing', context.params.documentId, original);

    const uppercase = original.toUpperCase();

    return snap.ref.set({uppercase}, {merge: true});
  });
