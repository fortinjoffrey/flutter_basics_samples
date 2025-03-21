import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:value_state/value_state.dart';

import '../../../shared/data/fake_data_source.dart';
import '../../../shared/models/user.dart';

part 'users_bloc_event.dart';
part 'users_bloc_state.dart';

class UsersBloc extends Bloc<UsersBlocEvent, UsersBlocState> {
  UsersBloc() : super(const UsersBlocState()) {
    on<UsersBlocEvent>(
      (event, emit) async {
        switch (event) {
          case GetUsersEvent():
            await _onGetUsers(event, emit);
            break;
          case ResetStateEvent():
            emit(const UsersBlocState());
            break;
          case ToggleSimulateErrorEvent():
            emit(state.copyWith(simulateError: !state.simulateError));
            break;
          case DeleteUserEvent():
            await _onDeleteUser(event, emit);
            break;

          case AddUserEvent():
            await _onAddUser(event, emit);
            break;
        }
      },
    );
  }

  Future<void> _onGetUsers(GetUsersEvent event, Emitter<UsersBlocState> emit) async {
    await state.usersState.fetchFrom(() async {
      return FakeDataSource().getUsers(throwError: state.simulateError);
    }).forEach((value) {
      emit(state.copyWith(usersState: value));
    });
  }

  Future<void> _onDeleteUser(DeleteUserEvent event, Emitter<UsersBlocState> emit) async {
    final users = state.usersState.data;
    if (users == null || state.usersState.isFetching) return;

    final userIndex = users.indexWhere((user) => user.id == event.user.id);
    if (userIndex == -1) return;

    final newUsers = List<User>.from(users);
    newUsers.removeAt(userIndex);

    emit(state.copyWith(usersState: Value.success(newUsers)));
  }

  Future<void> _onAddUser(AddUserEvent event, Emitter<UsersBlocState> emit) async {
    final users = state.usersState.data;
    if (users == null || state.usersState.isFetching) return;

    final newUsers = List<User>.from(users);
    newUsers.add(User(id: '${users.length + 1}', name: 'New User ${users.length + 1}', age: Random().nextInt(100)));

    emit(state.copyWith(usersState: Value.success(newUsers)));
  }
}
