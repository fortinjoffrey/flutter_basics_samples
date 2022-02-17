import 'package:auto_route/auto_route.dart';
import 'package:basics_samples/navigation/app_router.gr.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            AutoRouter.of(context).push(ColorfulRoute());
          },
          child: const Text('Go to red view'),
        ),
      ),
    );
  }
}
