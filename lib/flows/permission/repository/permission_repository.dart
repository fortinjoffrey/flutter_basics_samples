import 'package:flutter_basics_samples/dependencies_injector.dart';
import 'package:flutter_basics_samples/flows/permission/data/sources/permissions_sdk.dart';
import 'package:permission_handler/permission_handler.dart';

final class PermissionRepository {
  PermissionRepository({
    PermissionSdk? permissionSdk,
  }) : _permissionSdk = permissionSdk ?? sl<PermissionSdk>();

  final PermissionSdk _permissionSdk;

  Future<PermissionStatus> getLocationPermissionStatus() async {
    return await _permissionSdk.getForegroundLocationPermissionStatus();
  }

  Future<PermissionStatus> requestLocationPermissionStatus() async {
    return await _permissionSdk.requestForegroundLocationPermissionStatus();
  }
}
