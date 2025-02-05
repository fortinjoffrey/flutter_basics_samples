import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/packages/user_auth/user_auth_manager.dart';

class UserLoginInvitationPage extends StatelessWidget {
  const UserLoginInvitationPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Auth'),
      ),
      body: Center(
        child: TextButton(
          onPressed: UserAuthManager.instance.login,
          child: Text('Login'),
        ),
      ),
    );
  }
}
