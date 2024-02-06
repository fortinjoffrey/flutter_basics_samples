import 'package:bloc/bloc.dart';
import 'package:flutter_basics_samples/flows/feed/parts/List/presentation/bloc/feed_List_event.dart';
import 'package:flutter_basics_samples/flows/feed/parts/list/presentation/bloc/feed_list_state.dart';

class FeedListBloc extends Bloc<FeedListEvent, FeedListState> {
  FeedListBloc() : super(const FeedListState()) {
    on<FeedListEvent>((event, Emitter<FeedListState> emit) async {
      switch (event) {
        case InitEvent():
          break;
      }
    });
  }
}
