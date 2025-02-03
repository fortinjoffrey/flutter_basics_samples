import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class TokenProvider {
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();

  Future<void> setAccessToken(String token);
  Future<void> setRefreshToken(String token);
}

class TokenProviderImpl implements TokenProvider {
  final FlutterSecureStorage storage = FlutterSecureStorage();

  TokenProviderImpl();

  @override
  Future<String?> getAccessToken() async {
    return await storage.read(key: 'accessToken');
  }

  @override
  Future<String?> getRefreshToken() async {
    return await storage.read(key: 'refreshToken');
  }

  @override
  Future<void> setAccessToken(String token) async {
    await storage.write(key: 'accessToken', value: token);
  }

  @override
  Future<void> setRefreshToken(String token) async {
    await storage.write(key: 'refreshToken', value: token);
  }
}

class CoreHttpClient {
  final Dio dio;
  final TokenProvider tokenProvider;

  CoreHttpClient({required this.tokenProvider}) : dio = Dio();

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    final accessToken = await tokenProvider.getAccessToken();

    if (accessToken == null) {
      throw Exception('No access token');
    }

    return dio.get(path,
        queryParameters: queryParameters, options: Options(headers: {'Authorization': 'Bearer $accessToken'}));
  }
}
