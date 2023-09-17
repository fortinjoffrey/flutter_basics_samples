import 'dart:html';

import 'package:flutter_basics_samples/login/base_login.dart';

class LoginImpl extends BaseLogin {
  @override
  void login() {
    print('web');
    window.location.replace('https://strange-login-system.com/login');
  }
}