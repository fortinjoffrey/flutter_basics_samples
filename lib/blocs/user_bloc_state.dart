import 'package:flutter_basics_samples/packages/user_connection/models/user.dart';

sealed class UserBlocState {}

final class UserUnauthenticated extends UserBlocState {}

final class UserAuthenticated extends UserBlocState {
  final User user;

  UserAuthenticated({required this.user});
}
