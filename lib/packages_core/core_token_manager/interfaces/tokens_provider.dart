abstract class TokensProvider {
  Future<String?> get accessToken;
  Future<String?> get refreshToken;
}
