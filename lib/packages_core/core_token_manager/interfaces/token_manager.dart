import 'package:flutter_basics_samples/packages_core/core_token_manager/interfaces/tokens_provider.dart';

abstract interface class TokenManager implements TokensProvider {
  @override
  Future<String?> get accessToken;
  @override
  Future<String?> get refreshToken;
  
  Future<void> setAccessToken(String? token);
  Future<void> setRefreshToken(String? token);
}