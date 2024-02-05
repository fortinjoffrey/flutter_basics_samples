import 'package:flutter_basics_samples/dependy_injector.dart';
import 'package:flutter_basics_samples/flows/location/data/repositories/location_repository.dart';
import 'package:flutter_basics_samples/flows/location/data/sources/location_sdk.dart';
import 'package:flutter_basics_samples/shared/domain/usecases/usecase.dart';

class IsLocationServiceEnabled implements UseCase<Future<bool>, void> {
  IsLocationServiceEnabled({
    LocationRepository? locationRepository,
  }) : _locationRepository = locationRepository ??
            LocationRepository(
              locationSdk: sl<LocationSdk>(),
            );

  final LocationRepository _locationRepository;

  @override
  Future<bool> call([void params]) async {
    return await _locationRepository.isLocationServiceEnabled();
  }
}
