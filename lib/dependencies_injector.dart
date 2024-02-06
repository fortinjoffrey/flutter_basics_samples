import 'package:flutter_basics_samples/flows/location/data/repositories/location_repository.dart';
import 'package:flutter_basics_samples/flows/location/data/sources/location_sdk.dart';
import 'package:flutter_basics_samples/flows/location/domain/usecases/get_location.dart';
import 'package:flutter_basics_samples/flows/location/domain/usecases/is_location_service_enabled.dart';
import 'package:flutter_basics_samples/flows/location/domain/usecases/listen_for_location_updates.dart';
import 'package:flutter_basics_samples/flows/permission/data/sources/permissions_sdk.dart';
import 'package:flutter_basics_samples/flows/permission/domain/usecases/get_foreground_location_permission_status.dart';
import 'package:flutter_basics_samples/flows/permission/domain/usecases/request_foreground_location_permission.dart';
import 'package:flutter_basics_samples/flows/permission/repository/permission_repository.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

abstract class DependenciesInjector {
  static Future<void> init() async {
    // Sdk
    sl.registerLazySingleton<PermissionSdk>(() => PermissionSdk());
    sl.registerLazySingleton<LocationSdk>(() => LocationSdk());

    // Repositories
    sl.registerLazySingleton<PermissionRepository>(
      () => PermissionRepository(),
    );
    sl.registerLazySingleton<LocationRepository>(
      () => LocationRepository(),
    );

    // Permission usecases 
    sl.registerLazySingleton<GetForegroundLocationPermissionStatus>(
      () => GetForegroundLocationPermissionStatus(),
    );
    sl.registerLazySingleton<RequestForegroundLocationPermissionStatus>(
      () => RequestForegroundLocationPermissionStatus(),
    );

    // Location usecases 
    sl.registerLazySingleton<IsLocationServiceEnabled>(
      () => IsLocationServiceEnabled(),
    );
    sl.registerLazySingleton<GetLocation>(
      () => GetLocation(),
    );
    sl.registerLazySingleton<ListenForLocationUpdates>(
      () => ListenForLocationUpdates(),
    );
  }
}
