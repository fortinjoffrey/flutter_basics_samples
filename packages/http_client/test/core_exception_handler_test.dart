import 'package:core_http_client/src/core_exception_handler.dart';
import 'package:core_http_client/src/models/core_http_client_exception.dart';
import 'package:dio/dio.dart' as dio;
import 'package:test/test.dart';

void main() {
  late CoreHttpClientExceptionHandler handler;

  setUp(() {
    handler = CoreHttpClientExceptionHandler();
  });

  group('CoreHttpClientExceptionHandler', () {
    test('should return original error when not DioException', () {
      final error = Exception('test error');
      
      final result = handler.getError(error);
      
      expect(result, equals(error));
    });

    test('should map connection timeout error correctly', () {
      final dioError = dio.DioException(
        requestOptions: dio.RequestOptions(
          path: '/test',
          method: 'GET',
        ),
        type: dio.DioExceptionType.connectionTimeout,
      );

      final result = handler.getError(dioError) as CoreHttpClientException;

      expect(result.type, equals(CoreHttpClientExceptionType.connectionTimeout));
      expect(result.uri.path, equals('/test'));
      expect(result.method, equals('GET'));
    });

    test('should map send timeout error correctly', () {
      final dioError = dio.DioException(
        requestOptions: dio.RequestOptions(
          path: '/test',
          method: 'POST',
        ),
        type: dio.DioExceptionType.sendTimeout,
      );

      final result = handler.getError(dioError) as CoreHttpClientException;

      expect(result.type, equals(CoreHttpClientExceptionType.sendTimeout));
    });

    test('should map receive timeout error correctly', () {
      final dioError = dio.DioException(
        requestOptions: dio.RequestOptions(
          path: '/test',
          method: 'GET',
        ),
        type: dio.DioExceptionType.receiveTimeout,
      );

      final result = handler.getError(dioError) as CoreHttpClientException;

      expect(result.type, equals(CoreHttpClientExceptionType.receiveTimeout));
    });

    test('should map bad response error correctly', () {
      final dioError = dio.DioException(
        requestOptions: dio.RequestOptions(
          path: '/test',
          method: 'GET',
        ),
        type: dio.DioExceptionType.badResponse,
        response: dio.Response(
          statusCode: 404,
          requestOptions: dio.RequestOptions(path: '/test'),
        ),
      );

      final result = handler.getError(dioError) as CoreHttpClientException;

      expect(result.type, equals(CoreHttpClientExceptionType.badResponse));
      expect(result.statusCode, equals(404));
    });

    test('should map connection error correctly', () {
      final dioError = dio.DioException(
        requestOptions: dio.RequestOptions(
          path: '/test',
          method: 'GET',
        ),
        type: dio.DioExceptionType.connectionError,
      );

      final result = handler.getError(dioError) as CoreHttpClientException;

      expect(result.type, equals(CoreHttpClientExceptionType.connectionError));
    });

    test('should map cancel error correctly', () {
      final dioError = dio.DioException(
        requestOptions: dio.RequestOptions(
          path: '/test',
          method: 'GET',
        ),
        type: dio.DioExceptionType.cancel,
      );

      final result = handler.getError(dioError) as CoreHttpClientException;

      expect(result.type, equals(CoreHttpClientExceptionType.cancel));
    });

    test('should map unknown error correctly', () {
      final dioError = dio.DioException(
        requestOptions: dio.RequestOptions(
          path: '/test',
          method: 'GET',
        ),
        type: dio.DioExceptionType.unknown,
      );

      final result = handler.getError(dioError) as CoreHttpClientException;

      expect(result.type, equals(CoreHttpClientExceptionType.unknown));
    });

    test('should preserve request details in mapped exception', () {
      final dioError = dio.DioException(
        requestOptions: dio.RequestOptions(
          path: '/test',
          method: 'POST',
          headers: {'Content-Type': 'application/json'},
          queryParameters: {'param': 'value'},
          data: {'key': 'value'},
        ),
        type: dio.DioExceptionType.badResponse,
        message: 'Error message',
        error: 'Original error',
      );

      final result = handler.getError(dioError) as CoreHttpClientException;

      expect(result.uri.path, equals('/test'));
      expect(result.method, equals('POST'));
      expect(result.headers, containsPair('Content-Type', 'application/json'));
      expect(result.queryParameters, containsPair('param', 'value'));
      expect(result.data, equals({'key': 'value'}));
      expect(result.message, equals('Error message'));
      expect(result.error, equals('Original error'));
    });
  });
}
