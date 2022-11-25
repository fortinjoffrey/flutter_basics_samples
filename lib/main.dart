import 'package:basics_samples/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/auth_provider.dart';
import 'data/preferences_manager.dart';
import 'firebase_options.dart';
import 'screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp(
    sharedPreferences: sharedPreferences,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;

  const MyApp({super.key, required this.sharedPreferences});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => PreferencesManager(sharedPreferences: sharedPreferences),
        ),
        Provider(
          create: (context) => AuthProvider(
            preferencesManager: context.read<PreferencesManager>(),
            firebaseAuth: FirebaseAuth.instance,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Firebase Sign In Options',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Builder(
          builder: (context) {
            final authProvider = context.read<AuthProvider>();
            return authProvider.isUserSignedIn
                ? HomeScreen(
                    userEmail: authProvider.userEmail,
                    loginMethod: authProvider.loginMethod,
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
