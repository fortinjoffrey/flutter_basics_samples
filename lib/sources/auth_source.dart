import 'package:basics_samples/sources/firebase_functions_source.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthSource {
  final FirebaseFunctionsSource firebaseFunctionsSource;

  const AuthSource({required this.firebaseFunctionsSource});

  Future<void> saveDeviceToken({
    required String deviceToken,
    required String platform,
  }) async {
    firebaseFunctionsSource.saveDeviceToken(
      deviceToken: deviceToken,
      platform: platform,
    );
  }

  Future<void> deleteDeviceToken({
    required String deviceToken,
    required String idToken,
  }) async {
    firebaseFunctionsSource.deleteDeviceToken(
      deviceToken: deviceToken,
      idToken: idToken,
    );
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signUpWithEmailAndPasswordAndUsername({
    required String email,
    required String password,
    required String username,
  }) async {
    final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

    await userCredential.user?.updateDisplayName(username);
    await firebaseFunctionsSource.createUserData();
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
