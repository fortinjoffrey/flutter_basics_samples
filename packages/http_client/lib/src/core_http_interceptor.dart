import 'package:dio/dio.dart' as dio;
import 'interfaces/interceptor.dart';
import 'mappers/response_mapper.dart';

class CoreHttpInterceptor extends dio.Interceptor {
  final Interceptor interceptor;

  CoreHttpInterceptor({
    required this.interceptor,
  });

  @override
  void onRequest(dio.RequestOptions options, dio.RequestInterceptorHandler handler) {
    interceptor.onRequest(options.uri.toString(), options.data);

    handler.next(options);
  }

  @override
  void onResponse(dio.Response response, dio.ResponseInterceptorHandler handler) {
    interceptor.onResponse(mapDioResponse(response));
    handler.next(response);
  }

  @override
  void onError(dio.DioException err, dio.ErrorInterceptorHandler handler) {
    interceptor.onError(err);
    handler.next(err);
  }
}
