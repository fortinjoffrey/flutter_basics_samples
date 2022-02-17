import 'package:auto_route/auto_route.dart';
import 'package:basics_samples/navigation/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final sharedPreferences = await SharedPreferences.getInstance();
            sharedPreferences.setBool('loggedIn', true);
            AutoRouter.of(context).replace(const MainRoute());
          },
          child: Text('LOG IN'),
        ),
      ),
    );
  }
}
