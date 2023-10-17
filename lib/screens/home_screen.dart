import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/sign_up_dialog.dart';
import 'package:flutter_basics_samples/router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            const DetailsRoute(
              itemId: '1',
              itemName: 'Name 1',
              isFavorite: true,
              shoudShowDialog: true,
              initialSignUpStep: SignUpSteps.name,
            ).go(context);
          },
          child: const Text("go('/home/details/1?item-name:Name 1')"),
        ),
      ),
    );
  }
}
