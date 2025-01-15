import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LoggerInterceptor extends Interceptor {
  final Logger _logger = Logger();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.d('REQUEST[${options.method}] => PATH: ${options.path}');
    if (options.headers.isNotEmpty) {
      _logger.d('Headers: ${options.headers}');
    }
    if (options.data != null) {
      _logger.d('Body: ${options.data}');
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.d('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    if (response.data != null) {
      _logger.d('Response: ${response.data}');
    }
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
      error: err.error,
      stackTrace: err.stackTrace,
    );
    if (err.response?.data != null) {
      _logger.e('Error Response: ${err.response?.data}');
    }
    return handler.next(err);
  }
}
