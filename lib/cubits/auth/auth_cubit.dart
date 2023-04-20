import 'dart:developer';

import 'package:basics_samples/cubits/auth/auth_state.dart';
import 'package:basics_samples/models/app_user.dart';
import 'package:basics_samples/sources/auth_source.dart';
import 'package:basics_samples/sources/firestore_source.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthCubit extends Cubit<AuthState> {
  final AppUser? currentAppUser;
  final String? deviceToken;
  final AuthSource authSource;
  final String operatingSystem;

  AuthCubit({
    required this.currentAppUser,
    required this.authSource,
    required this.deviceToken,
    required this.operatingSystem,
  }) : super(
          AuthState(currentUser: currentAppUser),
        ) {
    // TODO: see if really necessary
    final currentAppUser = this.currentAppUser;
    final deviceToken = this.deviceToken;
    if (currentAppUser != null && deviceToken != null) {
      authSource.saveDeviceToken(
        deviceToken: deviceToken,
        platform: operatingSystem,
      );
    }
  }

  Future<void> onUserAuthChanges() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      emit(AuthState(currentUser: null));
    } else {
      final result = await FirestoreSource().getCurrentUserInfo();

      final deviceToken = this.deviceToken;
      // on user signing in save its device token
      if (deviceToken != null) {
        authSource.saveDeviceToken(
          deviceToken: deviceToken,
          platform: operatingSystem,
        );
      }

      emit(AuthState(currentUser: result));
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await authSource.signInWithEmailAndPassword(email, password);
    } catch (e) {
      log(e.toString());
    }
    onUserAuthChanges();
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    await authSource.signUpWithEmailAndPasswordAndUsername(
      email: email,
      password: password,
      username: username,
    );

    onUserAuthChanges();
  }

  Future<void> signOut() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) throw Exception();

    final idToken = await currentUser.getIdToken();
    await authSource.signOut();

    final deviceToken = this.deviceToken;
    // on user sign out delete its device token
    if (deviceToken != null) {
      authSource.deleteDeviceToken(
        deviceToken: deviceToken,
        idToken: idToken,
      );
    }
    onUserAuthChanges();
  }

  
}
