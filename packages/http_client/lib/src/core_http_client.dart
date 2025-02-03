import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'interfaces/base_url_provider.dart';
import 'interfaces/http_observer.dart';

import 'core_exception_handler.dart';
import 'models/core_http_client_exception.dart';
import 'interfaces/http_client.dart';
import 'interfaces/token_provider.dart';
import 'models/core_http_response.dart';
import 'dio_observer_adapter.dart';

class CoreHttpClient implements HttpClient {
  final dio.Dio _dio;
  final TokenProvider _tokenProvider;
  final BaseUrlProvider _baseUrlProvider;
  final CoreHttpClientExceptionHandler _exceptionHandler;

  static const _defaultContentType = 'application/json; charset=utf-8';

  CoreHttpClient({
    required TokenProvider tokenProvider,
    required BaseUrlProvider baseUrlProvider,
    required dio.Dio dio,
    HttpObserver? httpObserver,
  })  : _dio = dio,
        _tokenProvider = tokenProvider,
        _baseUrlProvider = baseUrlProvider,
        _exceptionHandler = CoreHttpClientExceptionHandler() {
    if (httpObserver != null) {
      _dio.interceptors.add(
        DioObserverAdapter(httpObserver: httpObserver),
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
      final error = _exceptionHandler.getError(e);
      throw error;
    }
  }

  @override
  Future<T> post<R, T>(
    String endpoint, {
    required dynamic data,
    String? contentType,
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
      throw _exceptionHandler.getError(e);
    }
  }

  @override
  Future<T> put<R, T>(
    String endpoint, {
    required dynamic data,
    String? contentType,
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
      throw _exceptionHandler.getError(e);
    }
  }

  @override
  Future<T> patch<R, T>(
    String endpoint, {
    required dynamic data,
    String? contentType,
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
      throw _exceptionHandler.getError(e);
    }
  }

  @override
  Future<T> delete<R, T>(
    String endpoint, {
    dynamic data,
    String? contentType,
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
      throw _exceptionHandler.getError(e);
    }
  }

  Future<T> _handleResponse<R, T>(dio.Response<R> response, T Function(R) builder) {
    // Si R est void, on retourne directement void/null sans appeler le builder
    if (null is R) {
      return Future<T>.value();
    }

    final R? data = response.data;
    if (data == null) {
      _throwEmptyResponseException(response);
    }
    return Future<T>.value(builder(data));
  }

  // Future<T> _handleResponse<R, T>(dio.Response<R> response, T Function(R) builder) {
  //   final R? data = response.data;

  //   if (R == Null) return Future<T>.value(null);

  //   if (data == null) {
  //     _throwEmptyResponseException(response);
  //   }

  //   return Future<T>.value(builder(data));
  // }

  void _initClientOptions({
    String? contentType = _defaultContentType,
    required bool authorizationNeeded,
    String? baseUrl,
    Map<String, dynamic>? extraHeaders,
  }) {
    _dio.options = _dio.options.copyWith(
      baseUrl: baseUrl ?? _baseUrlProvider.baseUrl,
      contentType: contentType,
      headers: <String, dynamic>{
        if (authorizationNeeded) HttpHeaders.authorizationHeader: 'Bearer ${_tokenProvider.token}',
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
      response: CoreHttpResponse(
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
