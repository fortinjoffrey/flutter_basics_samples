import 'logger.dart';

import 'base_url_provider.dart';
import 'token_provider.dart';

abstract class HttpClient {
  final TokenProvider tokenProvider;
  final BaseUrlProvider baseUrlProvider;
  final Logger? logger;

  HttpClient({
    required this.tokenProvider,
    required this.baseUrlProvider,
    this.logger,
  });

  Future<T> get<R, T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    required T Function(R) builder,
    bool authorizationNeeded = true,
    String? baseUrl,
    Map<String, dynamic>? extraHeaders,
  });

  Future<T> post<R, T>(
    String endpoint, {
    required dynamic data,
    String contentType = 'application/json; charset=utf-8',
    required T Function(R) builder,
    required bool authorizationNeeded,
    Map<String, dynamic>? extraHeaders,
  });

  Future<T> put<R, T>(
    String endpoint, {
    required dynamic data,
    String contentType = 'application/json; charset=utf-8',
    required T Function(R) builder,
    required bool authorizationNeeded,
    Map<String, dynamic>? extraHeaders,
  });

  Future<T> patch<R, T>(
    String endpoint, {
    required dynamic data,
    String contentType = 'application/json; charset=utf-8',
    required T Function(R) builder,
    required bool authorizationNeeded,
    Map<String, dynamic>? extraHeaders,
  });

  Future<T> delete<R, T>(
    String endpoint, {
    dynamic data,
    String contentType = 'application/json; charset=utf-8',
    required T Function(R) builder,
    required bool authorizationNeeded,
    Map<String, dynamic>? extraHeaders,
    Map<String, dynamic>? queryParameters,
  });
}
