import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_basics_samples/blocs/user_bloc_event.dart';
import 'package:flutter_basics_samples/blocs/user_bloc_state.dart';
import 'package:flutter_basics_samples/packages/user_connection/models/user.dart';
import 'package:flutter_basics_samples/packages/user_connection/user_manager.dart';

class UserBloc extends Bloc<UserBlocEvent, UserBlocState> {
  final User? currentUser;
  late final StreamSubscription<User?> _userSubscription;

  UserBloc({required this.currentUser})
      : super(currentUser != null ? UserAuthenticated(user: currentUser) : UserUnauthenticated()) {
    on<UserLogoutEvent>(_onLogout);
    on<UserChangesEvent>(_onUserChanges);

    _userSubscription = UserManager.instance.onUserChanges.listen((user) {
      add(UserChangesEvent(user: user));
    });
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }

  Future<void> _onLogout(UserLogoutEvent event, Emitter<UserBlocState> emit) async {
    await UserManager.instance.logout();
  }

  void _onUserChanges(UserChangesEvent event, Emitter<UserBlocState> emit) {
    final user = event.user;
    if (user == null) {
      emit(UserUnauthenticated());
    } else {
      emit(UserAuthenticated(user: user));
    }
  }
}
