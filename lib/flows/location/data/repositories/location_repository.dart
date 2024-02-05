import 'package:flutter_basics_samples/dependy_injector.dart';
import 'package:flutter_basics_samples/flows/location/data/sources/location_sdk.dart';
import 'package:location/location.dart';

final class LocationRepository {
  final LocationSdk _locationSdk;

  LocationRepository({
    LocationSdk? locationSdk,
  }) : _locationSdk = locationSdk ?? sl<LocationSdk>();

  Future<bool> isLocationServiceEnabled() async {
    return await _locationSdk.isLocationServiceEnabled();
  }

  Future<LocationData> getLocation() async {
    return await _locationSdk.getLocation();
  }

  Stream<LocationData> get onLocationChanged => _locationSdk.onLocationChanged;

  Future<void> init() async{
    await _locationSdk.init();
  }
}
