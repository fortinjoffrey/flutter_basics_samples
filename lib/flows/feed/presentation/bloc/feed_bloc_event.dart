part of 'feed_bloc.dart';

sealed class FeedBlocEvent {
  const FeedBlocEvent();
}

final class ToggleDisplayModeEvent extends FeedBlocEvent {
  const ToggleDisplayModeEvent();

  @override
  String toString() {
    return 'ToggleDisplayModeEvent';
  }
}

sealed class FeedDisplayMode {
  const FeedDisplayMode();
}

final class FeedMapDisplayMode extends FeedDisplayMode {
  const FeedMapDisplayMode();

  @override
  String toString() {
    return 'FeedMapDisplayMode';
  }
}

final class FeedListDisplayMode extends FeedDisplayMode {
  const FeedListDisplayMode();

  @override
  String toString() {
    return 'FeedListDisplayMode';
  }
}
