import 'package:basics_samples/examples/value_cubit_using_custom_state/users_list_state.dart';
import 'package:bloc/bloc.dart';
import 'package:value_cubit/value_cubit.dart';

import 'package:basics_samples/shared/data/fake_data_source.dart';

class UsersListCubit extends Cubit<UsersListState> {
  UsersListCubit() : super(UsersListState());

  Future<void> loadUsers() async {
    state.getUsersState.perform((state) async {
      return FakeDataSource()
          .getUsers(
            noValue: this.state.simulateNoValueForNextFetching,
            throwError: this.state.simulateErrorForNextFetching,
          )
          .toFutureState();
    }).listen((newState) {
      emit(state.copyWith(getUsersState: newState));
    });
  }

  void toggleSimulateErrorForNextFetching() {
    emit(state.copyWith(simulateErrorForNextFetching: !state.simulateErrorForNextFetching));
  }

  void toggleSimulateNoValueForNextFetching() {
    emit(state.copyWith(simulateNoValueForNextFetching: !state.simulateNoValueForNextFetching));
  }
}
