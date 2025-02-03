abstract interface class HttpClient {
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
    String? contentType,
    required T Function(R) builder,
    required bool authorizationNeeded,
    Map<String, dynamic>? extraHeaders,
  });

  Future<T> put<R, T>(
    String endpoint, {
    required dynamic data,
    String? contentType,
    required T Function(R) builder,
    required bool authorizationNeeded,
    Map<String, dynamic>? extraHeaders,
  });

  Future<T> patch<R, T>(
    String endpoint, {
    required dynamic data,
    String? contentType,
    required T Function(R) builder,
    required bool authorizationNeeded,
    Map<String, dynamic>? extraHeaders,
  });

  Future<T> delete<R, T>(
    String endpoint, {
    dynamic data,
    String? contentType,
    required T Function(R) builder,
    required bool authorizationNeeded,
    Map<String, dynamic>? extraHeaders,
    Map<String, dynamic>? queryParameters,
  });
}
