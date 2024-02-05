import 'package:location/location.dart';

final class LocationSdk {
  final Location location = Location();

  Stream<LocationData> get onLocationChanged => location.onLocationChanged;

  Future<void> init() async {
    try {
      // TODO: (JFO) rappeler cette méthode mise en foreground
      await location.enableBackgroundMode(enable: true);
    } catch (e) {
      // nothing to do
    }
  }

  Future<LocationData> getLocation() async {
    return await location.getLocation();
  }

  Future<bool> isLocationServiceEnabled() async {
    return await location.serviceEnabled();
  }
}
