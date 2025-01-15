import 'package:dio/dio.dart' as dio;
import 'core_exceptions.dart';
import 'mappers/response_mapper.dart';

class CoreHttpClientExceptionHandler {
  Object getError(Object e) {
    if (e is! dio.DioException) {
      return e;
    }

    return CoreHttpClientException(
      uri: e.requestOptions.uri,
      method: e.requestOptions.method,
      headers: e.requestOptions.headers,
      queryParameters: e.requestOptions.queryParameters,
      data: e.requestOptions.data,
      response: e.response != null ? mapDioResponse(e.response!) : null,
      type: _mapDioExceptionType(e.type),
      error: e.error,
      stackTrace: e.stackTrace,
      message: e.message,
    );
  }

  CoreHttpClientExceptionType _mapDioExceptionType(dio.DioExceptionType type) {
    return switch (type) {
      dio.DioExceptionType.connectionTimeout => CoreHttpClientExceptionType.connectionTimeout,
      dio.DioExceptionType.sendTimeout => CoreHttpClientExceptionType.sendTimeout,
      dio.DioExceptionType.receiveTimeout => CoreHttpClientExceptionType.receiveTimeout,
      dio.DioExceptionType.badResponse => CoreHttpClientExceptionType.badResponse,
      dio.DioExceptionType.cancel => CoreHttpClientExceptionType.cancel,
      dio.DioExceptionType.connectionError => CoreHttpClientExceptionType.connectionError,
      _ => CoreHttpClientExceptionType.unknown,
    };
  }
}
