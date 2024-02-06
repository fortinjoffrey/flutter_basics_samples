import 'package:flutter_basics_samples/dependencies_injector.dart';
import 'package:flutter_basics_samples/flows/location/data/sources/location_sdk.dart';
import 'package:flutter_basics_samples/flows/location/domain/models/location_model.dart';
import 'package:location/location.dart';

final class LocationRepository {
  final LocationSdk _locationSdk;

  LocationRepository({
    LocationSdk? locationSdk,
  }) : _locationSdk = locationSdk ?? sl<LocationSdk>();

  Future<bool> isLocationServiceEnabled() async {
    return await _locationSdk.isLocationServiceEnabled();
  }

  Future<LocationModel> getLocation() async {
    final locationData = await _locationSdk.getLocation();
    return LocationModel(locationData.latitude, locationData.longitude);
  }

  Stream<LocationModel> get onLocationChanged => _locationSdk.onLocationChanged.map(
        (LocationData locationData) => LocationModel(locationData.latitude, locationData.longitude),
      );

  Future<void> init() async {
    await _locationSdk.init();
  }
}
