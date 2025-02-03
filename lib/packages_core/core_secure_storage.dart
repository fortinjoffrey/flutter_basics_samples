import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CoreSecureStorage {
  final FlutterSecureStorage _storage;
  CoreSecureStorage() : _storage = FlutterSecureStorage();

  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }
}
