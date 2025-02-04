import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/packages/user_connection/user_manager.dart';

class UserConnectionWidget extends StatelessWidget {
  const UserConnectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Connection'),
      ),
      body: Center(
        child: TextButton(
          onPressed: UserManagerSDK.instance.login,
          child: Text('Connect'),
        ),
      ),
    );
  }
}
