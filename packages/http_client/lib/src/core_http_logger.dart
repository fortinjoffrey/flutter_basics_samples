import 'package:http_client/src/interfaces/logger.dart';
import 'package:http_client/src/response.dart';
import 'package:logger/logger.dart' as logger;

class CoreHttpLogger implements Logger {
  final logger.Logger _logger;

  CoreHttpLogger() : _logger = logger.Logger();

  @override
  void onError(Object error) {
    _logger.e(error);
  }

  @override
  void onRequest(String endpoint, Map<String, dynamic>? queryParameters) {
    _logger.i('REQUEST [${endpoint.split(' ').first}]: ${endpoint.split(' ').last}');
    if (queryParameters != null) {
      _logger.d('Query Parameters: $queryParameters');
    }
  }

  @override
  void onResponse(Response response) {
    _logger.i('RESPONSE Data: ${response.data}');
  }
}
