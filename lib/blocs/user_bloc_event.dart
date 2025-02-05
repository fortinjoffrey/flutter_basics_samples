import 'package:flutter_basics_samples/packages/user_auth/models/user.dart';

sealed class UserBlocEvent {
  const UserBlocEvent();
}

final class UserLogoutEvent extends UserBlocEvent {
  const UserLogoutEvent();
}

final class UserChangesEvent extends UserBlocEvent {
  const UserChangesEvent({required this.user});

  final User? user;
}
