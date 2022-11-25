import 'package:basics_samples/auth/auth_provider.dart';
import 'package:basics_samples/models/login_method.dart';
import 'package:basics_samples/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.userEmail,
    required this.loginMethod,
  });

  final String? userEmail;
  final LoginMethod loginMethod;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Logged in with ${widget.loginMethod.name}!'),
          const SizedBox(height: 32),
          Text('Email: ${widget.userEmail ?? 'error'}'),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () async {
              await context.read<AuthProvider>().signOut();
              if (!Navigator.of(context).canPop()) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(authProvider: context.read<AuthProvider>()),
                  ),
                );
              } else {
                Navigator.of(context).pop();
              }
            },
            child: const Text('Sign out'),
          ),
          _getText(),
          MyText(),
          TextButton(
            onPressed: () {
              setState((){});
            },
            child: const Text('setState'),
          ),
        ],
      ),
    ));
  }
}

class MyText extends StatelessWidget {
  const MyText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('Widget');
  }
}

Widget _getText() {
  return Text('Helper method');
}