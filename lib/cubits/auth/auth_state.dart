part of 'auth_cubit.dart';

@immutable
class AuthState {
  final bool isUserLoggedIn;

  const AuthState({
    required this.isUserLoggedIn,
  });
}
