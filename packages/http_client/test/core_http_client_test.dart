import 'package:core_http_client/http_client.dart';
import 'package:core_http_client/src/core_http_client.dart';
import 'package:core_http_client/src/dio_observer_adapter.dart';
import 'package:core_http_client/src/interfaces/http_observer.dart';
import 'package:dio/dio.dart' as dio;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockDio extends Mock implements dio.Dio {
  MockDio() {
    when(() => options).thenReturn(dio.BaseOptions());
  }
}

class MockTokenProvider extends Mock implements TokenProvider {
  @override
  String get token => 'mock_token';
}

class MockBaseUrlProvider extends Mock implements BaseUrlProvider {
  @override
  String get baseUrl => 'https://api.mock.com';
}

class MockInterceptor extends Mock implements HttpObserver {}

class MockCoreHttpInterceptor extends Mock implements DioObserverAdapter {}

void main() {
  late MockDio mockDio;
  late CoreHttpClient client;
  late MockTokenProvider mockTokenProvider;
  late MockBaseUrlProvider mockBaseUrlProvider;

  setUpAll(() {
    registerFallbackValue(dio.BaseOptions());
    registerFallbackValue(dio.RequestOptions(path: ''));
    registerFallbackValue(MockCoreHttpInterceptor());
    registerFallbackValue(MockInterceptor());
  });

  setUp(() {
    mockDio = MockDio();
    mockTokenProvider = MockTokenProvider();
    mockBaseUrlProvider = MockBaseUrlProvider();

    client = CoreHttpClient(
      tokenProvider: mockTokenProvider,
      baseUrlProvider: mockBaseUrlProvider,
      dio: mockDio,
    );
  });

  group('HTTP Methods Tests', () {
    test('GET method should call dio.get and return correct data', () async {
      final mockResponseData = {'data': 'test_value'};
      when(() => mockDio.get<Map<String, dynamic>>(
            any(),
            queryParameters: any(named: 'queryParameters'),
          )).thenAnswer((_) async => dio.Response(
            data: mockResponseData,
            statusCode: 200,
            requestOptions: dio.RequestOptions(path: ''),
          ));

      final result = await client.get<Map<String, dynamic>, String>(
        '/test',
        builder: (data) => data['data'] as String,
      );

      verify(() => mockDio.get<Map<String, dynamic>>(
            '/test',
            queryParameters: null,
          )).called(1);

      expect(result, equals('test_value'));
    });

    test('POST method should call dio.post and return correct data', () async {
      final mockResponseData = {'data': 'test_value'};
      when(() => mockDio.post<Map<String, dynamic>>(
            any(),
            data: any(named: 'data'),
          )).thenAnswer((_) async => dio.Response(
            data: mockResponseData,
            statusCode: 201,
            requestOptions: dio.RequestOptions(path: ''),
          ));

      final result = await client.post<Map<String, dynamic>, String>(
        '/test',
        data: {'test': 'data'},
        builder: (data) => data['data'] as String,
        authorizationNeeded: true,
      );

      verify(() => mockDio.post<Map<String, dynamic>>(
            '/test',
            data: {'test': 'data'},
          )).called(1);

      expect(result, equals('test_value'));
    });

    test('PUT method should call dio.put and return correct data', () async {
      final mockResponseData = {'data': 'test_value'};
      when(() => mockDio.put<Map<String, dynamic>>(
            any(),
            data: any(named: 'data'),
          )).thenAnswer((_) async => dio.Response(
            data: mockResponseData,
            statusCode: 200,
            requestOptions: dio.RequestOptions(path: ''),
          ));

      final result = await client.put<Map<String, dynamic>, String>(
        '/test',
        data: {'test': 'data'},
        builder: (data) => data['data'] as String,
        authorizationNeeded: true,
      );

      verify(() => mockDio.put<Map<String, dynamic>>(
            '/test',
            data: {'test': 'data'},
          )).called(1);

      expect(result, equals('test_value'));
    });

    test('PATCH method should call dio.patch and return correct data', () async {
      final mockResponseData = {'data': 'test_value'};
      when(() => mockDio.patch<Map<String, dynamic>>(
            any(),
            data: any(named: 'data'),
          )).thenAnswer((_) async => dio.Response(
            data: mockResponseData,
            statusCode: 200,
            requestOptions: dio.RequestOptions(path: ''),
          ));

      final result = await client.patch<Map<String, dynamic>, String>(
        '/test',
        data: {'test': 'data'},
        builder: (data) => data['data'] as String,
        authorizationNeeded: true,
      );

      verify(() => mockDio.patch<Map<String, dynamic>>(
            '/test',
            data: {'test': 'data'},
          )).called(1);

      expect(result, equals('test_value'));
    });

    test('DELETE method should call dio.delete and return correct data', () async {
      final mockResponseData = {'data': 'test_value'};
      when(() => mockDio.delete<Map<String, dynamic>>(
            any(),
            data: any(named: 'data'),
            queryParameters: any(named: 'queryParameters'),
          )).thenAnswer((_) async => dio.Response(
            data: mockResponseData,
            statusCode: 200,
            requestOptions: dio.RequestOptions(path: ''),
          ));

      final result = await client.delete<Map<String, dynamic>, String>(
        '/test',
        data: {'test': 'data'},
        builder: (data) => data['data'] as String,
        authorizationNeeded: true,
      );

      verify(() => mockDio.delete<Map<String, dynamic>>(
            '/test',
            data: {'test': 'data'},
            queryParameters: null,
          )).called(1);

      expect(result, equals('test_value'));
    });
  });

  group('Base URL Tests', () {
    test('should use custom base URL when provided', () async {
      when(() => mockDio.get<Map<String, dynamic>>(any())).thenAnswer(
        (_) async => dio.Response(
          data: {'data': 'test'},
          statusCode: 200,
          requestOptions: dio.RequestOptions(path: ''),
        ),
      );

      await client.get<Map<String, dynamic>, String>(
        '/test',
        builder: (data) => data['data'] as String,
        baseUrl: 'https://custom-api.com',
      );

      verify(() => mockDio.options = any(
            that: predicate((dio.BaseOptions options) => options.baseUrl == 'https://custom-api.com'),
          )).called(1);
    });

    test('should use default base URL when custom is not provided', () async {
      when(() => mockDio.get<Map<String, dynamic>>(any())).thenAnswer(
        (_) async => dio.Response(
          data: {'data': 'test'},
          statusCode: 200,
          requestOptions: dio.RequestOptions(path: ''),
        ),
      );

      await client.get<Map<String, dynamic>, String>(
        '/test',
        builder: (data) => data['data'] as String,
      );

      verify(() => mockDio.options = any(
            that: predicate((dio.BaseOptions options) => options.baseUrl == 'https://api.mock.com'),
          )).called(1);
    });
  });

  group('Headers Tests', () {
    test('should add extra headers when provided', () async {
      when(() => mockDio.get<Map<String, dynamic>>(any())).thenAnswer(
        (_) async => dio.Response(
          data: {'data': 'test'},
          statusCode: 200,
          requestOptions: dio.RequestOptions(path: ''),
        ),
      );

      await client.get<Map<String, dynamic>, String>(
        '/test',
        builder: (data) => data['data'] as String,
        extraHeaders: {'Custom-Header': 'value'},
      );

      verify(() => mockDio.options = any(
            that: predicate((dio.BaseOptions options) => options.headers['Custom-Header'] == 'value'),
          )).called(1);
    });

    test('should set content type correctly', () async {
      when(() => mockDio.post<Map<String, dynamic>>(any(), data: any(named: 'data'))).thenAnswer(
        (_) async => dio.Response(
          data: {'data': 'test'},
          statusCode: 200,
          requestOptions: dio.RequestOptions(path: ''),
        ),
      );

      await client.post<Map<String, dynamic>, String>(
        '/test',
        data: {'test': 'data'},
        builder: (data) => data['data'] as String,
        contentType: 'application/xml',
        authorizationNeeded: true,
      );

      verify(() => mockDio.options = any(
            that: predicate((dio.BaseOptions options) => options.contentType == 'application/xml'),
          )).called(1);
    });
  });

  group('Authorization Tests', () {
    test('should add authorization header when authorizationNeeded is true', () async {
      when(() => mockDio.get<Map<String, dynamic>>(any())).thenAnswer(
        (_) async => dio.Response(
          data: {'data': 'test'},
          statusCode: 200,
          requestOptions: dio.RequestOptions(path: ''),
        ),
      );

      await client.get<Map<String, dynamic>, String>(
        '/test',
        builder: (data) => data['data'] as String,
        authorizationNeeded: true,
      );

      verify(() => mockDio.options = any(
            that: predicate((dio.BaseOptions options) => options.headers['Authorization'] == 'Bearer mock_token'),
          )).called(1);
    });

    test('should not add authorization header when authorizationNeeded is false', () async {
      when(() => mockDio.get<Map<String, dynamic>>(any())).thenAnswer(
        (_) async => dio.Response(
          data: {'data': 'test'},
          statusCode: 200,
          requestOptions: dio.RequestOptions(path: ''),
        ),
      );

      await client.get<Map<String, dynamic>, String>(
        '/test',
        builder: (data) => data['data'] as String,
        authorizationNeeded: false,
      );

      verify(() => mockDio.options = any(
            that: predicate((dio.BaseOptions options) => !options.headers.containsKey('Authorization')),
          )).called(1);
    });
  });

  group('Error Handling Tests', () {
    test('should handle connection timeout', () async {
      when(() => mockDio.get<Map<String, dynamic>>(any())).thenThrow(
        dio.DioException(
          requestOptions: dio.RequestOptions(path: ''),
          type: dio.DioExceptionType.connectionTimeout,
        ),
      );

      expect(
        () => client.get<Map<String, dynamic>, String>(
          '/test',
          builder: (data) => data['data'] as String,
        ),
        throwsA(isA<CoreHttpClientException>()),
      );
    });

    test('should handle empty response data', () async {
      when(() => mockDio.get<Map<String, dynamic>>(any())).thenAnswer(
        (_) async => dio.Response<Map<String, dynamic>>(
          data: null,
          statusCode: 200,
          requestOptions: dio.RequestOptions(path: ''),
        ),
      );

      expect(
        () => client.get<Map<String, dynamic>, String>(
          '/test',
          builder: (data) => data['data'] as String,
        ),
        throwsA(isA<CoreHttpClientException>()),
      );
    });

    test('should handle server error', () async {
      when(() => mockDio.get<Map<String, dynamic>>(any())).thenThrow(
        dio.DioException(
          requestOptions: dio.RequestOptions(path: ''),
          response: dio.Response(
            statusCode: 500,
            requestOptions: dio.RequestOptions(path: ''),
          ),
        ),
      );

      expect(
        () => client.get<Map<String, dynamic>, String>(
          '/test',
          builder: (data) => data['data'] as String,
        ),
        throwsA(isA<CoreHttpClientException>()),
      );
    });
  });

  group('Builder Tests', () {
    test('should correctly transform response data using builder', () async {
      final mockResponseData = {'id': 1, 'name': 'Test User', 'email': 'test@example.com'};

      when(() => mockDio.get<Map<String, dynamic>>(any())).thenAnswer(
        (_) async => dio.Response(
          data: mockResponseData,
          statusCode: 200,
          requestOptions: dio.RequestOptions(path: ''),
        ),
      );

      final result = await client.get<Map<String, dynamic>, String>(
        '/test',
        builder: (data) => data['name'] as String,
      );

      expect(result, equals('Test User'));
    });

    test('should handle complex object transformation in builder', () async {
      final mockResponseData = {
        'users': [
          {'id': 1, 'name': 'User 1'},
          {'id': 2, 'name': 'User 2'},
        ]
      };

      when(() => mockDio.get<Map<String, dynamic>>(any())).thenAnswer(
        (_) async => dio.Response(
          data: mockResponseData,
          statusCode: 200,
          requestOptions: dio.RequestOptions(path: ''),
        ),
      );

      final result = await client.get<Map<String, dynamic>, List<String>>(
        '/test',
        builder: (data) => (data['users'] as List).map((user) => user['name'] as String).toList(),
      );

      expect(result, equals(['User 1', 'User 2']));
    });

    test('should throw when builder throws', () async {
      final mockResponseData = {'wrongKey': 'value'};

      when(() => mockDio.get<Map<String, dynamic>>(any())).thenAnswer(
        (_) async => dio.Response(
          data: mockResponseData,
          statusCode: 200,
          requestOptions: dio.RequestOptions(path: ''),
        ),
      );

      expect(
        () => client.get<Map<String, dynamic>, String>(
          '/test',
          builder: (data) => data['nonExistentKey'] as String,
        ),
        throwsA(isA<TypeError>()),
      );
    });

    test('should handle null response with void type parameter', () async {
      when(() => mockDio.get<void>(any())).thenAnswer(
        (_) async => dio.Response<void>(
          data: null,
          statusCode: 204,
          requestOptions: dio.RequestOptions(path: ''),
        ),
      );

      await client.get<void, void>(
        '/test',
        builder: (_) {},
      );
    });

    test('should handle different input and output types', () async {
      final mockResponseData = {'count': '42'};

      when(() => mockDio.get<Map<String, dynamic>>(any())).thenAnswer(
        (_) async => dio.Response(
          data: mockResponseData,
          statusCode: 200,
          requestOptions: dio.RequestOptions(path: ''),
        ),
      );

      final result = await client.get<Map<String, dynamic>, int>(
        '/test',
        builder: (data) => int.parse(data['count'] as String),
      );

      expect(result, equals(42));
    });
  });
}
