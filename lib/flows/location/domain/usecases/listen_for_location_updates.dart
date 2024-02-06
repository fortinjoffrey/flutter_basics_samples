import 'package:flutter_basics_samples/dependencies_injector.dart';
import 'package:flutter_basics_samples/flows/location/data/repositories/location_repository.dart';
import 'package:flutter_basics_samples/flows/location/data/sources/location_sdk.dart';
import 'package:flutter_basics_samples/flows/location/domain/models/location_model.dart';
import 'package:flutter_basics_samples/shared/domain/usecases/usecase.dart';

class ListenForLocationUpdates implements UseCase<Future<Stream<LocationModel>>, void> {
  ListenForLocationUpdates({
    LocationRepository? locationRepository,
  }) : _locationRepository = locationRepository ??
            LocationRepository(
              locationSdk: sl<LocationSdk>(),
            );

  final LocationRepository _locationRepository;

  @override
  Future<Stream<LocationModel>> call([void params]) async {
    await _locationRepository.init();
    return _locationRepository.onLocationChanged;
  }
}
