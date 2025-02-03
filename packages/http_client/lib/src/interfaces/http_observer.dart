abstract interface class HttpObserver {
  void onRequest(String endpoint, Map<String, dynamic>? queryParameters);
  void onResponse(dynamic data, final int? statusCode);
  void onError(Object error);
}
