import 'package:flutter_basics_samples/packages_core/core_secure_storage.dart';
import 'package:flutter_basics_samples/packages_core/core_token_manager/interfaces/token_manager.dart';

class UserTokensManager implements TokenManager {
  final CoreSecureStorage _storage;

  static const _accessTokenKey = 'accessToken';
  static const _refreshTokenKey = 'refreshToken';

  UserTokensManager({CoreSecureStorage? storage}) : _storage = storage ?? CoreSecureStorage();

  @override
  Future<String?> get accessToken => _storage.read(_accessTokenKey);

  @override
  Future<String?> get refreshToken => _storage.read(_refreshTokenKey);

  @override
  Future<void> setAccessToken(String? token) async {
    if (token == null) {
      await _storage.delete(_accessTokenKey);
    } else {
      await _storage.write(_accessTokenKey, token);
    }
  }

  @override
  Future<void> setRefreshToken(String? token) async {
    if (token == null) {
      await _storage.delete(_refreshTokenKey);
    } else {
      await _storage.write(_refreshTokenKey, token);
    }
  }
}
