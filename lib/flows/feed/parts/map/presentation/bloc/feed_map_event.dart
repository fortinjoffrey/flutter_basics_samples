sealed class FeedMapEvent {
  const FeedMapEvent();
}

final class SwitchMapModeEvent extends FeedMapEvent {
  final MapMode mode;

  const SwitchMapModeEvent(this.mode);
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
