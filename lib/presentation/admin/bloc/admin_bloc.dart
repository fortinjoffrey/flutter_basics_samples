import 'package:flutter_basics_samples/presentation/admin/bloc/admin_bloc_event.dart';
import 'package:flutter_basics_samples/presentation/admin/bloc/admin_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc() : super(AdminState()) {
    on<AdminStateChangedEvent>((event, emit) {
      emit(state.copyWith(tab: event.tab));
    });
  }
}
