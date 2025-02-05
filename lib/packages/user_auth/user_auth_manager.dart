import 'dart:async';

import 'package:flutter_basics_samples/packages/user_auth/models/user.dart';
import 'package:flutter_basics_samples/packages_core/core_http_client/core_http_client.dart';
import 'package:flutter_basics_samples/packages_core/core_tokens_manager/interfaces/tokens_manager.dart';
import 'package:flutter_basics_samples/packages_core/core_tokens_manager/user_tokens_manager.dart';

class UserAuthManager {
  static UserAuthManager? _instance;
  // ignore: unused_field
  final CoreHttpClient _client;
  final TokensManager _tokenManager;
  final StreamController<User?> _userController = StreamController<User?>.broadcast();

  User? _currentUser;

  Stream<User?> get onUserChanges => _userController.stream;
  User? get currentUser => _currentUser;

  UserAuthManager._internal(TokensManager tokenManager)
      : _tokenManager = tokenManager,
        _client = CoreHttpClient(tokenProvider: tokenManager) {
    _userController.stream.listen((user) {
      _currentUser = user;
    });
  }

  static Future<void> initialize() async {
    final tokenManager = UserTokensManager.instance;
    _instance = UserAuthManager._internal(tokenManager);
    await _instance!._restoreUserSession();
  }

  static UserAuthManager get instance {
    if (_instance == null) {
      throw StateError('UserAuthManagerSDK not initialized. Call initialize() first.');
    }
    return _instance!;
  }

  Future<void> _restoreUserSession() async {
    final accessToken = await _tokenManager.accessToken;

    if (accessToken != null) {
      try {
        // final response = await _client.get('https://renault.com/user');
        final response = {
          'vehicleIds': ['id-1', 'id-2'],
          'id': 'id-1',
          'email': 'test@test.com',
        };
        final user = User.fromMap(response);
        _currentUser = user;
      } catch (e) {
        await logout();
      }
    }
  }

  Future<void> login() async {
    // 1. Do login method here and get accessToken and refreshToken

    // 2. Storage tokens via token manager
    await _tokenManager.setAccessToken('AiOlZ3*');
    await _tokenManager.setRefreshToken('Bo1Z1!');

    // 3. Get user information
    // final response = await _client.get('https://renault.com/user');
    final response = {
      'vehicleIds': ['id-1', 'id-2'],
      'id': 'id-1',
      'email': 'test@test.com',
    };
    final user = User.fromMap(response);

    // 4. Update user
    _userController.add(user);
  }

  Future<void> logout() async {
    await _tokenManager.setAccessToken(null);
    await _tokenManager.setRefreshToken(null);
    _userController.add(null);
  }
}
