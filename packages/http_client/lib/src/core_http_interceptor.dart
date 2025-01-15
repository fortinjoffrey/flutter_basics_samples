import 'package:dio/dio.dart' as dio;
import 'interfaces/logger.dart';
import 'mappers/response_mapper.dart';

class CoreHttpInterceptor extends dio.Interceptor {
  final Logger logger;

  CoreHttpInterceptor({
    required this.logger,
  });

  @override
  void onRequest(dio.RequestOptions options, dio.RequestInterceptorHandler handler) {
    logger.onRequest(options.uri.toString(), options.data);

    handler.next(options);
  }

  @override
  void onResponse(dio.Response response, dio.ResponseInterceptorHandler handler) {
    logger.onResponse(mapDioResponse(response));
    handler.next(response);
  }

  @override
  void onError(dio.DioException err, dio.ErrorInterceptorHandler handler) {
    logger.onError(err);
    handler.next(err);
  }
}
