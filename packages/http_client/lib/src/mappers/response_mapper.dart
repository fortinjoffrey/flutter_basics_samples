import 'package:dio/dio.dart' as dio;
import '../models/core_http_response.dart';

CoreHttpResponse<T> mapDioResponse<T>(dio.Response dioResponse) {
  return CoreHttpResponse(
    data: dioResponse.data,
    statusCode: dioResponse.statusCode,
    statusMessage: dioResponse.statusMessage,
    headers: dioResponse.headers.map,
    isRedirect: dioResponse.isRedirect,
    realUri: dioResponse.realUri,
    extra: dioResponse.extra,
  );
}
