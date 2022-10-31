import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

enum AuthCubitState { unknown, authenticated, unauthenticated }

class AuthCubit extends Cubit<AuthCubitState> {
  AuthCubit() : super(AuthCubitState.unknown);

  void logout() {
    emit(AuthCubitState.unauthenticated);
  }

  void tokenHasExpired() {
    emit(AuthCubitState.unauthenticated);
  }

  void login() {
    emit(AuthCubitState.authenticated);
  }

  @override
  void onChange(Change<AuthCubitState> change) {
    super.onChange(change);
    debugPrint(change.toString());
  }
}
