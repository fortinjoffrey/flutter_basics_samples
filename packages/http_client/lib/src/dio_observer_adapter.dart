import 'package:dio/dio.dart' as dio;
import 'interfaces/http_observer.dart';
import 'mappers/response_mapper.dart';

class DioObserverAdapter extends dio.Interceptor {
  final HttpObserver httpObserver;

  DioObserverAdapter({
    required this.httpObserver,
  });

  @override
  void onRequest(dio.RequestOptions options, dio.RequestInterceptorHandler handler) {
    httpObserver.onRequest(options.uri.toString(), options.data);

    handler.next(options);
  }

  @override
  void onResponse(dio.Response response, dio.ResponseInterceptorHandler handler) {
    final res = mapDioResponse(response);
    httpObserver.onResponse(res.data, res.statusCode);
    handler.next(response);
  }

  @override
  void onError(dio.DioException err, dio.ErrorInterceptorHandler handler) {
    httpObserver.onError(err);
    handler.next(err);
  }
}
