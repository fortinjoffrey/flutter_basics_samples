import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

const isUserLoggedInKey = 'isUserLoggedIn';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.sharedPreferences)
      : super(
          AuthState(
            isUserLoggedIn: sharedPreferences.getBool(isUserLoggedInKey) ?? false,
          ),
        );

  final SharedPreferences sharedPreferences;

  Future<void> login() async {
    sharedPreferences.setBool(isUserLoggedInKey, true);
    emit(AuthState(isUserLoggedIn: true));
  }

  Future<void> logout() async {
    sharedPreferences.setBool(isUserLoggedInKey, false);
    emit(AuthState(isUserLoggedIn: false));
  }
}
