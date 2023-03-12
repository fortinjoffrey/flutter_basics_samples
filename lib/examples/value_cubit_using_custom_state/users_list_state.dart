import '../../shared/data/user.dart';
import 'package:value_state/value_state.dart';

class UsersListState {
  final BaseState<List<User>> getUsersState;
  final bool simulateErrorForNextFetching;
  final bool simulateNoValueForNextFetching;

   const UsersListState({
    this.getUsersState = const InitState<List<User>>(),
    this.simulateErrorForNextFetching = false,
    this.simulateNoValueForNextFetching = false,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UsersListState &&
      other.getUsersState == getUsersState &&
      other.simulateErrorForNextFetching == simulateErrorForNextFetching &&
      other.simulateNoValueForNextFetching == simulateNoValueForNextFetching;
  }

  @override
  int get hashCode => getUsersState.hashCode ^ simulateErrorForNextFetching.hashCode ^ simulateNoValueForNextFetching.hashCode;

  UsersListState copyWith({
    BaseState<List<User>>? getUsersState,
    bool? simulateErrorForNextFetching,
    bool? simulateNoValueForNextFetching,
  }) {
    return UsersListState(
      getUsersState: getUsersState ?? this.getUsersState,
      simulateErrorForNextFetching: simulateErrorForNextFetching ?? this.simulateErrorForNextFetching,
      simulateNoValueForNextFetching: simulateNoValueForNextFetching ?? this.simulateNoValueForNextFetching,
    );
  }
}