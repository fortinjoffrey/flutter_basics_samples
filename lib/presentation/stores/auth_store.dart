import 'dart:async';

import 'package:basics_samples/data/firebase_firestore_source.dart';
import 'package:basics_samples/data/firebase_functions_source.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFunctionsSource _firebaseFunctionsSource;
  final FirebaseFirestoreSource _firebaseFirestoreSource;
  late final StreamSubscription<User?> _userChangesSubscription;

  _AuthStore({
    required FirebaseFunctionsSource firebaseFunctionsSource,
    required FirebaseFirestoreSource firebaseFirestoreSource,
  })  : _firebaseFunctionsSource = firebaseFunctionsSource,
        _firebaseFirestoreSource = firebaseFirestoreSource {
    _subscribeToUsersChanges();
  }

  void _subscribeToUsersChanges() {
    _userChangesSubscription = _auth.userChanges().listen((user) async {
      // if last user was anonymous and new is not then migrate
      if (currentUser != null && currentUser!.isAnonymous && user != null && !user.isAnonymous) {
        _firebaseFunctionsSource.migrateDataFromAnonymousPermanent(idToken);
      }
      currentUser = user;
      if (currentUser != null) {
        _firebaseFirestoreSource.fetchUserPolls();
      }
      idToken = await currentUser?.getIdToken();
    });
  }

  void dispose() {
    _userChangesSubscription.cancel();
  }

  @observable
  User? currentUser;

  @observable
  String? idToken;

  Future<void> signInAnonymously() async {
    await _auth.signInAnonymously();
  }

  Future<void> signInWithEmail() async {
    await _auth.signInWithEmailAndPassword(
      email: 'test@gmail.com',
      password: 'test1234',
    );
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
