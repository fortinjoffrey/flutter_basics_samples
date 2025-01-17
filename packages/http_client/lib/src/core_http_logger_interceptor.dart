import 'models/response.dart';
import 'package:logger/logger.dart' as logger;

import 'core_exception_handler.dart';
import 'interfaces/interceptor.dart';

abstract class LoggerInterface {
  void debug();
}

class CoreHttpLoggerInterceptor implements Interceptor {
  final logger.Logger _logger;

  CoreHttpLoggerInterceptor() : _logger = logger.Logger();

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
  void onResponse(Response response) {
    _logger.i('RESPONSE Data: ${response.data}');
  }
}
