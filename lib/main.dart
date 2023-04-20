import 'dart:io';

import 'package:basics_samples/cubits/all_users_page/all_users_page_cubit.dart';
import 'package:basics_samples/cubits/auth/auth_cubit.dart';
import 'package:basics_samples/cubits/auth/auth_state.dart';
import 'package:basics_samples/depency_injection.dart';
import 'package:basics_samples/sources/firebase_functions_source.dart';
import 'package:basics_samples/firebase_options.dart';
import 'package:basics_samples/models/app_user.dart';
import 'package:basics_samples/pages/all_users_page.dart';
import 'package:basics_samples/pages/sign_in_page.dart';
import 'package:basics_samples/sources/auth_source.dart';
import 'package:basics_samples/sources/firestore_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum FirebaseEnv { dev, prod }

const firebaseEnv = FirebaseEnv.prod;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await DependencyInjection.init();

  if (firebaseEnv == FirebaseEnv.dev) {
    FirebaseFunctions.instanceFor(region: 'europe-west3').useFunctionsEmulator('localhost', 5001);
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  }

  final currentUser = FirebaseAuth.instance.currentUser;
// FirebaseAuth.instance.signOut();
  AppUser? currentAppUser;
  if (currentUser != null) {
    currentAppUser = await FirestoreSource().getCurrentUserInfo();
  }

  final String? deviceToken = await FirebaseMessaging.instance.getToken();

  runApp(MyApp(
    currentAppUser: currentAppUser,
    deviceToken: deviceToken,
  ));
}

class MyApp extends StatelessWidget {
  final AppUser? currentAppUser;
  final String? deviceToken;

  const MyApp({
    super.key,
    required this.currentAppUser,
    required this.deviceToken,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(
        currentAppUser: currentAppUser,
        authSource: sl<AuthSource>(),
        deviceToken: deviceToken,
        operatingSystem: Platform.operatingSystem,
      ),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: state.currentUser != null
                ? BlocProvider<AllUsersCubit>(
                    create: (context) => AllUsersCubit(
                      firebaseFunctionsSource: sl<FirebaseFunctionsSource>(),
                      firestoreSource: sl<FirestoreSource>(),
                    ),
                    child: AllUsersPage(),
                  )
                : SignInPage(),
          );
        },
      ),
    );
  }
}
