import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttergooglesignin/screens/home_screen.dart';
import 'package:provider/provider.dart';

import 'auth/auth_provider.dart';
import 'firebase_options.dart';
import 'screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => AuthProvider(
        firebaseAuth: FirebaseAuth.instance,
      ),
      child: MaterialApp(
        title: 'Firebase Sign In Options',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: Builder(
          builder: (context) {
            final authProvider = context.read<AuthProvider>();
            return authProvider.isUserSignedIn
                ? HomeScreen(
                    userEmail: authProvider.userEmail,
                  )
                : LoginScreen(
                    authProvider: context.read<AuthProvider>(),
                  );
          },
        ),
      ),
    );
  }
}
