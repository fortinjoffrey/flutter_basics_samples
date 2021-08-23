import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key, this.onLogin}) : super(key: key);

  final void Function()? onLogin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final sharedPreferences = await SharedPreferences.getInstance();
            sharedPreferences.setBool('loggedIn', true);
            onLogin?.call();
          },
          child: Text('LOG IN'),
        ),
      ),
    );
  }
}
