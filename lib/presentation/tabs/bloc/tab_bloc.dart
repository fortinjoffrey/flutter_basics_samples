import 'package:flutter_basics_samples/presentation/tabs/bloc/tab_bloc_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabBloc extends Bloc<TabEvent, Tabs> {
  TabBloc() : super(Tabs.calendar) {
    on<TabChangedEvent>((event, emit) {
      emit(event.tab);
    });
  }
}
