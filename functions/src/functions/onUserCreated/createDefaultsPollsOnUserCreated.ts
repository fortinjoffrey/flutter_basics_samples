import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

export const createDefaultsPollsOnUserCreated = functions
  .region('europe-west3')
  .auth.user()
  .onCreate(async (user) => {
    functions.logger.log('user:', user);

    await admin
      .firestore()
      .collection('polls')
      .add({
        authorId: user.uid,
        authorName: 'James',
        event: {title: 'test'},
        invitedUserIds: [user.uid, 'foo', 'bar', 'baz'],
        options: [],
      });

    const ref = await admin
      .firestore()
      .collection('polls')
      .add({
        authorId: 'uid',
        authorName: 'Mike',
        event: {title: 'testInvite'},
        invitedUserIds: [user.uid, 'foo', 'bar', 'baz'],
        options: [],
      });

    await admin
      .firestore()
      .collection('polls')
      .doc(ref.id)
      .collection('responses')
      .add({
        user: {id: user.uid, name: 'foo'},
      });
    await admin
      .firestore()
      .collection('polls')
      .doc(ref.id)
      .collection('responses')
      .add({
        user: {id: 'foobar', name: 'bar'},
      });
  });
