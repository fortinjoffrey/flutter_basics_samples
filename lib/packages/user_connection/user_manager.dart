import 'dart:async';

import 'package:flutter_basics_samples/packages_core/core_http_client.dart';
import 'package:flutter_basics_samples/packages_core/core_secure_storage.dart';

import 'package:firebase_auth/firebase_auth.dart';

final t = FirebaseAuth.instance;
final v = UserManagerSDK.instance;

class User {
  final List<String> vehicleIds;
  final String id;

  const User({required this.vehicleIds, required this.id});
}

class UserManagerSDK {
  static UserManagerSDK? _instance;
  final CoreHttpClient _client;
  final TokenProvider tokenProvider;
  final StreamController<User?> _userController = StreamController<User?>();

  Stream<User?> get userStream => _userController.stream;

  UserManagerSDK._internal(this.tokenProvider) : _client = CoreHttpClient(tokenProvider: tokenProvider);

  static void initialize(TokenProvider tokenProvider) {
    _instance = UserManagerSDK._internal(tokenProvider);
  }

  static UserManagerSDK get instance {
    if (_instance == null) {
      throw StateError('UserManagerSDK not initialized. Call initialize() first.');
    }
    return _instance!;
  }

  Future<void> login() async {
    // open webview
    // se connecte
    // stocker les tokens dans le secure storage
    final storage = CoreSecureStorage();
    storage.write('accessToken', 'accessToken');
    storage.write('refreshToken', 'refreshToken');
    final response = await _client.get('https://api.example.com/user');
    _userController.add(
      User(
        vehicleIds: response.data['vehicleIds'],
        id: response.data['id'],
      ),
    );
  }

  Future<void> logout() async {
    final storage = CoreSecureStorage();
    storage.delete('accessToken');
    storage.delete('refreshToken');
    _userController.add(null);
  }
}
