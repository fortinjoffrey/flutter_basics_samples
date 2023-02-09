import * as admin from 'firebase-admin';

export {migrateDataFromAnonymousPermanent} from './functions/onCall/migrateDataFromAnonymousPermanent.js';
export {migrateExistingPollToPollWithCreatedDate} from './functions/onCall/migrateExistingPollToPollWithCreatedDate.js';
export {createDefaultsPollsOnUserCreated} from './functions/onUserCreated/createDefaultsPollsOnUserCreated.js';
export {createMessage} from './functions/onCall/createMessage.js';
// eslint-disable-next-line max-len
export {makeOriginalPropertyForMessageUppercase} from './functions/onMessageCreated/makeOriginalPropertyForMessageUppercase.js';
export {addCreatedDateOnPollCreated} from './functions/onPollCreated/addCreatedDateOnPollCreated.js';
// eslint-disable-next-line max-len
export {addCreatedDateOnPollResponseCreated} from './functions/onPollResponseCreated/addCreatedDateOnPollResponseCreated.js';
export {updateLastUpdatedDateOnPollUpdated} from './functions/onPollUpdated/updateLastUpdatedDateOnPollUpdated.js';

admin.initializeApp();
