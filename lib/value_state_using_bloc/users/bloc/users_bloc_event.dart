part of 'users_bloc.dart';

sealed class UsersBlocEvent {}

class ResetStateEvent extends UsersBlocEvent {}

class GetUsersEvent extends UsersBlocEvent {}

class ToggleSimulateErrorEvent extends UsersBlocEvent {}

class DeleteUserEvent extends UsersBlocEvent {
  final User user;

  DeleteUserEvent(this.user);
}

class AddUserEvent extends UsersBlocEvent {}
