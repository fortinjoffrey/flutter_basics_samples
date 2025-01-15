import 'interfaces/logger.dart';
import 'response.dart';

class CoreLoggerInterceptor {
  final Logger _logger;

  CoreLoggerInterceptor(this._logger);

  void onRequest(String method, String url, Map<String, dynamic>? headers, dynamic data) {
    _logger.onRequest(url, null);
  }

  void onResponse(Response response) {
    _logger.onResponse(response);
  }

  void onError(Object error) {
    _logger.onError(error);
  }
} 