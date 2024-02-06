import 'package:google_maps_flutter/google_maps_flutter.dart';

sealed class FeedMapEvent {
  const FeedMapEvent();
}

class LockOnMeEvent extends FeedMapEvent {
  const LockOnMeEvent();

  @override
  String toString() {
    return 'OnLockOnMyPositionSelected';
  }
}

class FreeModeEvent extends FeedMapEvent {
  const FreeModeEvent();

  @override
  String toString() {
    return 'FreeModeEvent';
  }
}

class OnWillDisappear extends FeedMapEvent {
  const OnWillDisappear();

  @override
  String toString() {
    return 'OnWillDisappear';
  }

}
class OnWillAppearEvent extends FeedMapEvent {
  const OnWillAppearEvent();

  @override
  String toString() {
    return 'OnWillAppearEvent';
  }
}

final class SwitchMapModeEvent extends FeedMapEvent {
  final MapMode mode;

  const SwitchMapModeEvent(this.mode);

  @override
  String toString() {
    return 'SwitchMapModeEvent';
  }
}

final class InitEvent extends FeedMapEvent {
  const InitEvent();

  @override
  String toString() {
    return 'InitEvent';
  }
}

final class FeedAppResumedEvent extends FeedMapEvent {
  const FeedAppResumedEvent();
}

final class LocationUpdateEvent extends FeedMapEvent {
  const LocationUpdateEvent(this.latLng);

  final LatLng latLng;

  @override
  String toString() {
    return 'LocationUpdateEvent';
  }
}

sealed class MapMode {
  const MapMode();
}

final class CenterOnEiffelTowerMapMode extends MapMode {
  const CenterOnEiffelTowerMapMode();

  @override
  String toString() {
    return 'CenterOnEiffelTowerMapMode';
  }

}

final class CenterOnUserLocationMapMode extends MapMode {
  const CenterOnUserLocationMapMode();

  @override
  String toString() {
    return 'CenterOnUserLocationMapMode';
  }

}

final class FreeMoveMapMode extends MapMode {
  const FreeMoveMapMode();

  @override
  String toString() {
    return 'FreeMoveMapMode';
  }
}
