import 'package:basics_samples/data/sources/remote_source.dart';
import 'package:basics_samples/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_user_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('fetchUser', () {
    late MockClient client;
    late RemoteSource remoteSource;

    setUp(() {
      client = MockClient();
      remoteSource = RemoteSource(client: client);
    });

    test('returns a User if the http call completes successfully', () async {
      when(client.get(Uri.parse('https://jsonplaceholder.typicode.com/users/1'))).thenAnswer(
          (_) async => http.Response('{"id": 1, "name": "Leanne Graham", "email": "Sincere@april.biz"}', 200));

      expect(await remoteSource.fetchUser(), isA<User>());
    });

    test('returns the right User if the http call completes successfully', () async {
      final user = User(id: 1, name: 'Leanne Graham', email: 'Sincere@april.biz');

      when(client.get(Uri.parse('https://jsonplaceholder.typicode.com/users/1'))).thenAnswer(
          (_) async => http.Response('{"id": 1, "name": "Leanne Graham", "email": "Sincere@april.biz"}', 200));

      expect(await remoteSource.fetchUser(), user);
    });

    test('throws an exception if the http call completes with an error', () {
      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse('https://jsonplaceholder.typicode.com/users/1')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(remoteSource.fetchUser(), throwsException);
    });
  });
}
