import 'package:basics_samples/data/sources/remote_source.dart';
import 'package:basics_samples/domain/entities/album.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_album_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('fetchAlbum', () {
    late MockClient client;
    late RemoteSource remoteSource;

    setUp(() {
      client = MockClient();
      remoteSource = RemoteSource(client: client);
    });
    test('returns an Album if the http call completes successfully', () async {
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
          .thenAnswer((_) async => http.Response('{"userId": 1, "id": 2, "title": "mock"}', 200));

      expect(await remoteSource.fetchAlbum(), isA<Album>());
    });

    test('returns the right Album if the http call completes successfully', () async {
      final album = Album(id: 2, title: 'mock', userId: 1);
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
          .thenAnswer((_) async => http.Response('{"userId": 1, "id": 2, "title": "mock"}', 200));

      expect(await remoteSource.fetchAlbum(), album);
    });

    test('throws an exception if the http call completes with an error', () {
      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(remoteSource.fetchAlbum(), throwsException);
    });
  });
}
