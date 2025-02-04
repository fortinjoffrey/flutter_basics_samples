import 'package:flutter_basics_samples/packages/garage/models/vehicle.dart';
import 'package:flutter_basics_samples/packages_core/core_http_client/core_http_client.dart';
import 'package:flutter_basics_samples/packages_core/core_tokens_manager/interfaces/tokens_manager.dart';
import 'package:flutter_basics_samples/packages_core/core_tokens_manager/user_tokens_manager.dart';

class GarageManager {
  static GarageManager? _instance;
  // ignore: unused_field
  final CoreHttpClient _client;

  GarageManager._internal(TokensManager tokenManager)
      : _client = CoreHttpClient(tokenProvider: tokenManager);

  static Future<void> initialize() async {
    final tokenManager = UserTokensManager.instance;
    _instance = GarageManager._internal(tokenManager);
  }

  static GarageManager get instance {
    if (_instance == null) {
      throw StateError('GarageManager not initialized. Call initialize() first.');
    }
    return _instance!;
  }

  Future<List<Vehicle>> getVehicles() async {
    // final response = await _client.get('/vehicles');
    final response = [
      {
        'id': 'id-1',
        'licensePlate': 'AA-123-AA',
        'year': 2020,
      },
      {
        'id': 'id-2',
        'licensePlate': 'BB-456-BB',
        'year': 2024,
      },
    ];
    return response.map((e) => Vehicle.fromMap(e)).toList();
  }
}
