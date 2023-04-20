import 'package:basics_samples/models/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreSource {

  // TODO: do this in a cloud function instead
  // TODO: this function will 
  Future<List<AppUser>> getUsers() async {
    final snapshot = await FirebaseFirestore.instance.collection('users').get();

    final appUsers = snapshot.docs.map((e) => AppUser.fromJson(e.data())).toList();

    appUsers.removeWhere((appUser) => appUser.uid == FirebaseAuth.instance.currentUser?.uid);

    return appUsers;
  }

  Future<AppUser> getCurrentUserInfo() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) throw Exception('No current user');

    final snapshot = await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).get();

    final data = snapshot.data();

    if (data == null) throw Exception();

    return AppUser.fromJson(data);
  }
}
