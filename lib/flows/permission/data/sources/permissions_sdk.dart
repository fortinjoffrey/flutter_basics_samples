import 'package:permission_handler/permission_handler.dart';

class PermissionSdk {
  Future<PermissionStatus> getForegroundLocationPermissionStatus() async {
    return await _getPermissionStatus(Permission.locationWhenInUse);
  }

  Future<PermissionStatus> requestForegroundLocationPermissionStatus() async {
    return await _requestPermission(Permission.locationWhenInUse);
  }

  Future<PermissionStatus> _getPermissionStatus(Permission permission) async {
    return await permission.status;
  }

  Future<PermissionStatus> _requestPermission(Permission permission) async {
    final status = await permission.request();
    return status;
  }

  Future<bool> openAppSettings() async {
    return await openAppSettings();
  }
}


  // Future<bool> askUserPermissionForForegroundLocation() async {
  //   return await _permissionHandlerService.request(_foregroundPermission) == PermissionStatus.granted;
  // }
  // Future<bool> shouldAskForegroundPermission() async {
  //   // we can ask this only once in a native popup
  //   final permission = await _permissionHandlerService.status(_foregroundPermission);
  //   return permission.isGranted;
  // }

  // Future<bool> isForegroundLocationPermissionGranted() async {
  //   return await _permissionHandlerService.serviceStatus(_foregroundPermission).isEnabled &&
  //       await _permissionHandlerService.status(_foregroundPermission).isGranted;
  // }

  // Future<bool> isForegroundLocationPermissionPermanentlyDenied() =>
  //     _permissionHandlerService.status(_foregroundPermission).isPermanentlyDenied;
