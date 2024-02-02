import 'package:flutter_basics_samples/flows/feed/parts/map/presentation/bloc/feed_map_event.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_map_state.freezed.dart';

@freezed
class FeedMapState with _$FeedMapState {
  const factory FeedMapState({
    @Default(FreeMoveMapMode()) MapMode mode,
  }) = _FeedMapState;
}
