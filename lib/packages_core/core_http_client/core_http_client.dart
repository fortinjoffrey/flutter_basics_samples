import 'package:dio/dio.dart';
import 'package:flutter_basics_samples/packages_core/core_token_manager/interfaces/tokens_provider.dart';

class CoreHttpClient {
  final Dio dio;
  final TokensProvider tokenProvider;

  CoreHttpClient({required this.tokenProvider}) : dio = Dio();

  Future<Map<String, dynamic>> get(String path, {Map<String, dynamic>? queryParameters}) async {
    final accessToken = await tokenProvider.accessToken;

    if (accessToken == null) {
      throw Exception('No access token');
    }

    final response = await dio.get(path,
        queryParameters: queryParameters, options: Options(headers: {'Authorization': 'Bearer $accessToken'}));

    return response.data;
  }
}
