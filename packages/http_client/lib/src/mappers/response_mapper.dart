import 'package:dio/dio.dart' as dio;
import 'package:http_client/src/response.dart';

Response<T> mapDioResponse<T>(dio.Response dioResponse) {
  return Response(
    data: dioResponse.data,
    statusCode: dioResponse.statusCode,
    statusMessage: dioResponse.statusMessage,
    headers: dioResponse.headers.map,
    isRedirect: dioResponse.isRedirect,
    realUri: dioResponse.realUri,
    extra: dioResponse.extra,
  );
}
