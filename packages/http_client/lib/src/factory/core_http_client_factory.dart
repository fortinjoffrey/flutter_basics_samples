import '../../http_client.dart';
import '../core_http_client.dart';
import '../interfaces/http_observer.dart';
import 'package:dio/dio.dart' as dio;

class CoreHttpClientFactory {
  CoreHttpClientFactory._();

  static CoreHttpClient create({
    required TokenProvider tokenProvider,
    required BaseUrlProvider baseUrlProvider,
    HttpObserver? observer,
  }) {
    return CoreHttpClient(
      tokenProvider: tokenProvider,
      baseUrlProvider: baseUrlProvider,
      httpObserver: observer,
      dio: dio.Dio(),
    );
  }
}
