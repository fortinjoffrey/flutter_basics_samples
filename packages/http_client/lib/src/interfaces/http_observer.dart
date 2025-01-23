import '../models/core_http_response.dart';

abstract class HttpObserver {
  void onRequest(String endpoint, Map<String, dynamic>? queryParameters);
  void onResponse(CoreHttpResponse response);
  void onError(Object error);
}
