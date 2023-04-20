import 'package:basics_samples/models/app_user.dart';
import 'package:equatable/equatable.dart';

abstract class AllUsersState extends Equatable {
  const AllUsersState();
}

class AllUsersLoading extends AllUsersState {
  const AllUsersLoading();

  @override
  List<Object?> get props => [];
}

class AllUsersFailure extends AllUsersState {
  const AllUsersFailure();

  @override
  List<Object?> get props => [];
}

class AllUsersComplete extends AllUsersState {
  final List<AppUser> users;

  const AllUsersComplete({required this.users});

  @override
  List<Object?> get props => [users];
}
