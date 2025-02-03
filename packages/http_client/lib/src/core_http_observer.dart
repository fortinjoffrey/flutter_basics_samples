import 'package:logger/logger.dart' as logger;

import 'core_exception_handler.dart';
import 'interfaces/http_observer.dart';

class CoreHttpObserver implements HttpObserver {
  final logger.Logger _logger;

  CoreHttpObserver() : _logger = logger.Logger();

  @override
  void onError(Object error) {
    _logger.e(CoreHttpClientExceptionHandler().getError(error));
  }

  @override
  void onRequest(String endpoint, Map<String, dynamic>? queryParameters) {
    _logger.i('REQUEST [${endpoint.split(' ').first}]: ${endpoint.split(' ').last}');
    if (queryParameters != null) {
      _logger.d('Query Parameters: $queryParameters');
    }
  }

  @override
  void onResponse(dynamic data, final int? statusCode) {
    _logger.i('STATUS Code: $statusCode');
    _logger.i('RESPONSE Data: $data');
  }
}
