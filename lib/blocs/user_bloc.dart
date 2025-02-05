import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_basics_samples/blocs/user_bloc_event.dart';
import 'package:flutter_basics_samples/blocs/user_bloc_state.dart';
import 'package:flutter_basics_samples/packages/user_auth/models/user.dart';
import 'package:flutter_basics_samples/packages/user_auth/user_auth_manager.dart';

class UserBloc extends Bloc<UserBlocEvent, UserBlocState> {
  final User? currentUser;
  late final StreamSubscription<User?> _userSubscription;

  UserBloc({required this.currentUser})
      : super(currentUser != null ? UserAuthenticated(user: currentUser) : UserUnauthenticated()) {
    on<UserLogoutEvent>(_onLogout);
    on<UserChangesEvent>(_onUserChanges);

    _userSubscription = UserAuthManager.instance.onUserChanges.listen((user) {
      add(UserChangesEvent(user: user));
    });
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }

  Future<void> _onLogout(UserLogoutEvent event, Emitter<UserBlocState> emit) async {
    await UserAuthManager.instance.logout();
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
