import 'package:flutter_basics_samples/dependy_injector.dart';
import 'package:flutter_basics_samples/flows/location/data/repositories/location_repository.dart';
import 'package:flutter_basics_samples/flows/location/data/sources/location_sdk.dart';
import 'package:flutter_basics_samples/shared/domain/usecases/usecase.dart';
import 'package:location/location.dart';

class ListenForLocationUpdates implements UseCase<Future<Stream<LocationData>>, void> {
  ListenForLocationUpdates({
    LocationRepository? locationRepository,
  }) : _locationRepository = locationRepository ??
            LocationRepository(
              locationSdk: sl<LocationSdk>(),
            );

  final LocationRepository _locationRepository;

  @override
  Future<Stream<LocationData>> call([void params]) async {
    await _locationRepository.init();
    return _locationRepository.onLocationChanged;
  }
}
