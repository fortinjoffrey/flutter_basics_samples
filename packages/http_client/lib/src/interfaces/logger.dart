import 'package:http_client/src/response.dart';

abstract class Logger {
  void onRequest(String endpoint, Map<String, dynamic>? queryParameters);
  void onResponse(Response response);
  void onError(Object error);
}
