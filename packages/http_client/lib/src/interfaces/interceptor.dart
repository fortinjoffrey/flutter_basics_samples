import '../models/response.dart';

abstract class Interceptor {
  void onRequest(String endpoint, Map<String, dynamic>? queryParameters);
  void onResponse(Response response);
  void onError(Object error);
}
