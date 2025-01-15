import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:http_client/src/interfaces/base_url_provider.dart';
import 'package:http_client/src/interfaces/logger.dart';

import 'core_error_handler.dart';
import 'core_exceptions.dart';
import 'interfaces/http_client.dart';
import 'interfaces/token_provider.dart';
import 'response.dart';
import 'core_http_interceptor.dart';

// TODO: better solution to use dio interceptor but we need to redefine our own
//   RequestInterceptorHandler, Response, RequestOptions...
//   _dio.interceptors.add(LoggerInterceptor());

class CoreHttpClient extends HttpClient {
  final dio.Dio _dio;
  final CoreHttpClientErrorHandler _errorHandler;

  CoreHttpClient({
    required TokenProvider tokenProvider,
    required BaseUrlProvider baseUrlProvider,
    Logger? logger,
  })  : _dio = dio.Dio(),
        _errorHandler = CoreHttpClientErrorHandler(),
        super(
          tokenProvider: tokenProvider,
          baseUrlProvider: baseUrlProvider,
          logger: logger,
        ) {
    if (logger != null) {
      _dio.interceptors.add(
        CoreHttpInterceptor(logger: logger),
      );
    }
  }

  @override
  Future<T> get<R, T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    required T Function(R) builder,
    bool authorizationNeeded = true,
    String? baseUrl,
    Map<String, dynamic>? extraHeaders,
  }) async {
    try {
      _initClientOptions(
        authorizationNeeded: authorizationNeeded,
        baseUrl: baseUrl,
        extraHeaders: extraHeaders,
      );

      final response = await _dio.get<R>(
        endpoint,
        queryParameters: queryParameters,
      );

      return _handleResponse<R, T>(response, builder);
    } catch (e) {
      final error = _errorHandler.getError(e);
      throw error;
    }
  }

  @override
  Future<T> post<R, T>(
    String endpoint, {
    required dynamic data,
    String contentType = 'application/json; charset=utf-8',
    required T Function(R) builder,
    required bool authorizationNeeded,
    Map<String, dynamic>? extraHeaders,
  }) async {
    try {
      _initClientOptions(
        contentType: contentType,
        authorizationNeeded: authorizationNeeded,
        extraHeaders: extraHeaders,
      );

      final response = await _dio.post<R>(
        endpoint,
        data: data,
      );

      return _handleResponse<R, T>(response, builder);
    } catch (e) {
      throw _errorHandler.getError(e);
    }
  }

  @override
  Future<T> put<R, T>(
    String endpoint, {
    required dynamic data,
    String contentType = 'application/json; charset=utf-8',
    required T Function(R) builder,
    required bool authorizationNeeded,
    Map<String, dynamic>? extraHeaders,
  }) async {
    try {
      _initClientOptions(
        contentType: contentType,
        authorizationNeeded: authorizationNeeded,
        extraHeaders: extraHeaders,
      );

      final response = await _dio.put<R>(
        endpoint,
        data: data,
      );

      return _handleResponse<R, T>(response, builder);
    } catch (e) {
      throw _errorHandler.getError(e);
    }
  }

  @override
  Future<T> patch<R, T>(
    String endpoint, {
    required dynamic data,
    String contentType = 'application/json; charset=utf-8',
    required T Function(R) builder,
    required bool authorizationNeeded,
    Map<String, dynamic>? extraHeaders,
  }) async {
    try {
      _initClientOptions(
        contentType: contentType,
        authorizationNeeded: authorizationNeeded,
        extraHeaders: extraHeaders,
      );

      final response = await _dio.patch<R>(
        endpoint,
        data: data,
      );

      return _handleResponse<R, T>(response, builder);
    } catch (e) {
      throw _errorHandler.getError(e);
    }
  }

  @override
  Future<T> delete<R, T>(
    String endpoint, {
    dynamic data,
    String contentType = 'application/json; charset=utf-8',
    required T Function(R) builder,
    required bool authorizationNeeded,
    Map<String, dynamic>? extraHeaders,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      _initClientOptions(
        contentType: contentType,
        authorizationNeeded: authorizationNeeded,
        extraHeaders: extraHeaders,
      );

      final response = await _dio.delete<R>(
        endpoint,
        data: data,
        queryParameters: queryParameters,
      );

      return _handleResponse<R, T>(response, builder);
    } catch (e) {
      throw _errorHandler.getError(e);
    }
  }

  Future<T> _handleResponse<R, T>(dio.Response<R> response, T Function(R) builder) {
    final R? data = response.data;

    if (R == Null) return Future<T>.value(null);

    if (data == null) {
      _throwEmptyResponseException(response);
    }

    return Future<T>.value(builder(data));
  }

  void _initClientOptions({
    String? contentType = 'application/json; charset=utf-8',
    required bool authorizationNeeded,
    String? baseUrl,
    Map<String, dynamic>? extraHeaders,
  }) {
    _dio.options = _dio.options.copyWith(
      baseUrl: baseUrl ?? baseUrlProvider.baseUrl,
      contentType: contentType,
      headers: <String, dynamic>{
        if (authorizationNeeded) HttpHeaders.authorizationHeader: 'Bearer ${tokenProvider.token}',
        ...?extraHeaders,
      },
    );
  }

  Never _throwEmptyResponseException(dio.Response response) {
    throw CoreHttpClientException(
      uri: response.requestOptions.uri,
      method: response.requestOptions.method,
      headers: response.requestOptions.headers,
      queryParameters: response.requestOptions.queryParameters,
      type: CoreHttpClientExceptionType.emptyResponse,
      stackTrace: StackTrace.current,
      message: 'Response data is null',
      response: Response(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        headers: response.headers.map,
        isRedirect: response.isRedirect,
        realUri: response.realUri,
        extra: response.extra,
      ),
    );
  }
}
