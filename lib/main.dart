import 'package:basics_samples/data/firebase_firestore_source.dart';
import 'package:basics_samples/presentation/screens/home_screen.dart';
import 'package:basics_samples/presentation/stores/auth_store.dart';
import 'package:basics_samples/data/firebase_functions_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

enum FirebaseEnv { dev, prod }

const firebaseEnv = FirebaseEnv.dev;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (firebaseEnv == FirebaseEnv.dev) {
    FirebaseFunctions.instanceFor(region: 'europe-west3').useFunctionsEmulator('localhost', 5001);
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseFirestoreSource>(
          create: (_) => FirebaseFirestoreSource(),
        ),
        Provider<FirebaseFunctionsSource>(
          create: (_) => FirebaseFunctionsSource(),
        ),
        Provider<AuthStore>(
          create: (context) => AuthStore(
            firebaseFunctionsSource: context.read<FirebaseFunctionsSource>(),
            firebaseFirestoreSource: context.read<FirebaseFirestoreSource>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'fbs-cloud-functions',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
