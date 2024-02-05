import 'package:google_maps_flutter/google_maps_flutter.dart';

sealed class FeedMapEvent {
  const FeedMapEvent();
}

final class SwitchMapModeEvent extends FeedMapEvent {
  final MapMode mode;

  const SwitchMapModeEvent(this.mode);
}

final class InitEvent extends FeedMapEvent {
  const InitEvent();
}

final class FeedAppResumedEvent extends FeedMapEvent {
  const FeedAppResumedEvent();
}

final class LocationUpdateEvent extends FeedMapEvent {
  const LocationUpdateEvent(this.latLng);

  final LatLng latLng;
}

sealed class MapMode {
  const MapMode();
}

final class CenterOnEiffelTowerMapMode extends MapMode {
  const CenterOnEiffelTowerMapMode();
}

final class CenterOnUserLocationMapMode extends MapMode {
  const CenterOnUserLocationMapMode();
}

final class FreeMoveMapMode extends MapMode {
  const FreeMoveMapMode();
}
