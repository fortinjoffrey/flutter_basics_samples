import 'dart:convert';

import 'package:basics_samples/app/data/dtos/number_trivia_dto.dart';
import 'package:basics_samples/app/data/sources/number_trivia_remote_source.dart';
import 'package:basics_samples/core/error/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../json/json_utils.dart';

import 'number_trivia_remote_source_test.mocks.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([http.Client])
void main() {
  late NumberTriviaRemoteSource remoteSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    remoteSource = NumberTriviaRemoteSource(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200(int number) {
    when(mockHttpClient.get(Uri.parse('http://numbersapi.com/$number'), headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(JsonUtils.fromFile('trivia.json'), 200));
  }

  void setUpMockHttpClientFailure404(int number) {
    when(mockHttpClient.get(Uri.parse('http://numbersapi.com/$number'), headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getConcreteNumberTrivia', () {
    const tNumber = 1;
    final tNumberTriviaDto =
        NumberTriviaDto.fromJson(json.decode(JsonUtils.fromFile('trivia.json')) as Map<String, dynamic>);
    test(
      '''
      should perform a GET request on a URL with number
      being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200(tNumber);
        // act
        remoteSource.getConcreteNumberTrivia(tNumber);
        // assert
        verify(
          mockHttpClient.get(
            Uri.parse('http://numbersapi.com/$tNumber'),
            headers: {'Content-Type': 'application/json'},
          ),
        );
      },
    );

    test(
      'should return NumberTriviaDto when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200(tNumber);

        // act
        final result = await remoteSource.getConcreteNumberTrivia(tNumber);

        // assert
        expect(result, equals(tNumberTriviaDto));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404(tNumber);
        // act
        final call = remoteSource.getConcreteNumberTrivia;
        // assert
        expect(() => call(tNumber), throwsA(isA<ServerException>()));
      },
    );
  });
}
