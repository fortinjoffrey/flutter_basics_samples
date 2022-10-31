import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

enum AuthState { unknown, authenticated, unauthenticated }

abstract class AuthEvent {}

class LogoutRequested extends AuthEvent {}

class LoginRequested extends AuthEvent {}

class TokenExpired extends AuthEvent {}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.unknown) {
    on<LogoutRequested>((event, emit) {
      emit(AuthState.unauthenticated);
    });
    on<TokenExpired>((event, emit) {
      emit(AuthState.unauthenticated);
    });
    on<LoginRequested>((event, emit) {
      emit(AuthState.authenticated);
    });
  }

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    debugPrint(transition.toString());
    super.onTransition(transition);
  }
}
