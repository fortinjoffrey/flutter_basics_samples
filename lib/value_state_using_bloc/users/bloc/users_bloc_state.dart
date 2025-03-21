part of 'users_bloc.dart';

class UsersBlocState {
  final Value<List<User>> usersState;
  final bool simulateError;

  const UsersBlocState({
    this.usersState = const Value<List<User>>.initial(),
    this.simulateError = false,
  });

  UsersBlocState copyWith({
    Value<List<User>>? usersState,
    bool? simulateError,
  }) {
    return UsersBlocState(
      usersState: usersState ?? this.usersState,
      simulateError: simulateError ?? this.simulateError,
    );
  }

  @override
  String toString() => 'UsersBlocState(users: $usersState, simulateError: $simulateError)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! UsersBlocState) return false;
    return other.usersState == usersState &&
      other.simulateError == simulateError;
  }

  @override
  int get hashCode => usersState.hashCode ^ simulateError.hashCode;
}

