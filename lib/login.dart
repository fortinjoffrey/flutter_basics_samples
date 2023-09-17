import 'login/stub_login.dart'
    if (dart.library.io) 'login/mobile_login.dart'
    if (dart.library.html) 'login/web_login.dart';

class Login {
  final LoginImpl _login;

  Login() : _login = LoginImpl();

  void login() {
    _login.login();
  }
}
