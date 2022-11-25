import 'package:basics_samples/data/preferences_manager.dart';
import 'package:basics_samples/models/login_method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthProvider {
  final PreferencesManager _preferencesManager;
  final FirebaseAuth _firebaseAuth;

  AuthProvider({required PreferencesManager preferencesManager, required FirebaseAuth firebaseAuth})
      : _preferencesManager = preferencesManager,
        _firebaseAuth = firebaseAuth;

  Future<UserCredential?> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    final AccessToken? accessToken = loginResult.accessToken;
await FacebookAuth.instance.getUserData();
    if (loginResult.status == LoginStatus.success && accessToken != null) {
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(accessToken.token);
      final UserCredential userCredential = await _firebaseAuth.signInWithCredential(facebookAuthCredential);

      _preferencesManager.setLoginMethod(LoginMethod.facebook);

      return userCredential;
    }
    return null;
  }

  Future<UserCredential?> signInWithGoogle() async {
    return null;
  }

  Future<UserCredential?> signInWithApple() async {
    return null;
  }

  // static Future<void> getFacebookUserData() async {
  //   final userData = await FacebookAuth.instance.getUserData();
  //   print(userData);
  // }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();

    final loginMethod = this.loginMethod;

    switch (loginMethod) {
      case LoginMethod.facebook:
        FacebookAuth.instance.logOut();
        return;
      default:
    }

    _preferencesManager.setLoginMethod(LoginMethod.none);
  }

  LoginMethod get loginMethod => _preferencesManager.getLoginMethod();

  String? get userEmail => _firebaseAuth.currentUser?.email;

  bool get isUserSignedIn => _firebaseAuth.currentUser != null;
}
