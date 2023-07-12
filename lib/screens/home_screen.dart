import 'package:flutter/material.dart';
import 'package:fluttergooglesignin/auth/auth_provider.dart';
import 'package:fluttergooglesignin/screens/login_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.userEmail,
  });

  final String? userEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Email: ${userEmail ?? 'error'}'),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                await context.read<AuthProvider>().signOut();

                // ignore: use_build_context_synchronously
                if (!Navigator.of(context).canPop()) {
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(
                        authProvider: context.read<AuthProvider>(),
                      ),
                    ),
                  );
                } else {
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }
}
