import 'package:basics_samples/models/login_method.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  final SharedPreferences _sharedPreferences;

  PreferencesManager({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  void setLoginMethod(LoginMethod method) {
    _sharedPreferences.setString('loginMethod', method.name);
  }

  LoginMethod getLoginMethod() {
    final loginMethodString = _sharedPreferences.getString('loginMethod');
    return getLoginMehodFromString(loginMethodString);
  }
}
