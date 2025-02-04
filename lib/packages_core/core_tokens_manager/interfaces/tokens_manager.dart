import 'package:flutter_basics_samples/packages_core/core_tokens_manager/interfaces/tokens_provider.dart';

abstract interface class TokensManager implements TokensProvider {
  @override
  Future<String?> get accessToken;
  @override
  Future<String?> get refreshToken;
  
  Future<void> setAccessToken(String? token);
  Future<void> setRefreshToken(String? token);
}