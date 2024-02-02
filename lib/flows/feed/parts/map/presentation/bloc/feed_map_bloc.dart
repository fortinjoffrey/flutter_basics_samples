import 'package:bloc/bloc.dart';
import 'package:flutter_basics_samples/flows/feed/parts/map/presentation/bloc/feed_map_event.dart';
import 'package:flutter_basics_samples/flows/feed/parts/map/presentation/bloc/feed_map_state.dart';

class FeedMapBloc extends Bloc<FeedMapEvent, FeedMapState> {
  FeedMapBloc() : super(const FeedMapState()) {
    on<FeedMapEvent>((event, emit) {
      if (event is SwitchMapModeEvent) {
        emit(state.copyWith(mode: event.mode));
      }
    });
  }
}
