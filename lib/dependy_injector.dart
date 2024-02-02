import 'package:flutter_basics_samples/flows/feed/domain/usecases/is_location_service_enabled.dart';
import 'package:flutter_basics_samples/flows/permission/data/sources/permissions_sdk.dart';
import 'package:flutter_basics_samples/flows/permission/domain/usecases/get_foreground_location_permission_status.dart';
import 'package:flutter_basics_samples/flows/permission/domain/usecases/request_foreground_location_permission.dart';
import 'package:flutter_basics_samples/flows/permission/repository/permission_repository.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

abstract class DepencyInjector {
  static Future<void> init() async {
    sl.registerLazySingleton<PermissionSdk>(() => PermissionSdk());

    sl.registerLazySingleton<PermissionRepository>(() => PermissionRepository(permissionSdk: sl()));

    sl.registerLazySingleton<IsLocationServiceEnabled>(() => IsLocationServiceEnabled());
    sl.registerLazySingleton<GetForegroundLocationPermissionStatus>(
        () => GetForegroundLocationPermissionStatus(permissionRepository: sl()));
    sl.registerLazySingleton<RequestForegroundLocationPermissionStatus>(
        () => RequestForegroundLocationPermissionStatus(permissionRepository: sl()));
  }
}
