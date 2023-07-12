import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider {
  final FirebaseAuth _firebaseAuth;

  AuthProvider({required FirebaseAuth firebaseAuth}) : _firebaseAuth = firebaseAuth;

  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? account = await GoogleSignIn().signIn();
    if (account == null) return null;

    final GoogleSignInAuthentication authTokens = await account.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: authTokens.accessToken,
      idToken: authTokens.idToken,
    );

    final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);

    return userCredential;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    GoogleSignIn().disconnect();
  }

  String? get userEmail => _firebaseAuth.currentUser?.email;

  bool get isUserSignedIn => _firebaseAuth.currentUser != null;
}
