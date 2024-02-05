part of 'feed_bloc.dart';

sealed class FeedBlocEvent {
  const FeedBlocEvent();
}

final class ToggleDisplayModeEvent extends FeedBlocEvent {
  const ToggleDisplayModeEvent();
}
sealed class FeedDisplayMode {
  const FeedDisplayMode();
}

final class FeedMapDisplayMode extends FeedDisplayMode {
  const FeedMapDisplayMode();
}

final class FeedListDisplayMode extends FeedDisplayMode {
  const FeedListDisplayMode();
}
