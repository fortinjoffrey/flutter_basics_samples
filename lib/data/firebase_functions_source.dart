import 'package:cloud_functions/cloud_functions.dart';

class FirebaseFunctionsSource {
  final functions = FirebaseFunctions.instanceFor(region: 'europe-west3');

  Future<dynamic> _call<T>(String name, [dynamic parameters]) async {
    try {
      final result = await functions.httpsCallable(name).call(parameters);
      print(result.data);
      return result.data;
    } on FirebaseFunctionsException catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<String> createMessage(String str) async {
    final data = await _call('createMessage', <String, dynamic>{'text': str}) as String;
    print(data);
    return data;
  }

  Future<void> migrateDataFromAnonymousPermanent(String? idToken) async {
    await _call('migrateDataFromAnonymousPermanent', {'idToken': idToken});
  }

  Future<void> migrateExistingPollToPollWithCreatedDate() async {
    await _call('migrateExistingPollToPollWithCreatedDate');
  }
}
