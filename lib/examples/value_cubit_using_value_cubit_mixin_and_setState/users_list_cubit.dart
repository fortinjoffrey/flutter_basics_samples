import '../../shared/data/fake_data_source.dart';
import '../../shared/data/user.dart';
import 'package:bloc/bloc.dart';
import 'package:value_cubit/value_cubit.dart';

class UsersListCubit extends Cubit<BaseState<List<User>>> with ValueCubitMixin {
  UsersListCubit() : super(const InitState<List<User>>());

  Future<void> loadUsers({bool throwError = false, bool noValue = false}) async {
    perform(() async {
      final users = await FakeDataSource().getUsers(noValue: noValue, throwError: throwError);

      if (users != null) {
        emit(ValueState(users));
      } else if (users == null) {
        emit(NoValueState());
      }
    });
  }
}
