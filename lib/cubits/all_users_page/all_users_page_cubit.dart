import 'package:basics_samples/cubits/all_users_page/all_users_state.dart';
import 'package:basics_samples/sources/firebase_functions_source.dart';
import 'package:basics_samples/sources/firestore_source.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AllUsersCubit extends Cubit<AllUsersState> {
  AllUsersCubit({
    required this.firebaseFunctionsSource,
    required this.firestoreSource,
  }) : super(const AllUsersLoading()) {
    fetchAllUsers();
  }

  final FirebaseFunctionsSource firebaseFunctionsSource;
  final FirestoreSource firestoreSource;

  Future<void> fetchAllUsers() async {
    try {
      final users = await firestoreSource.getUsers();
      emit(AllUsersComplete(users: users));
    } catch (e) {
      emit(AllUsersFailure());
    }
  }

  Future<void> followUser(String targetUserUID) async {
    final state = this.state;

    if (!(state is AllUsersComplete)) return;

    final User? currentUser = FirebaseAuth.instance.currentUser;
    final String? currentUserDisplayName = FirebaseAuth.instance.currentUser?.displayName;
    
    if (currentUser == null || currentUserDisplayName == null) throw Exception();

    await firebaseFunctionsSource.followUser(
      followerUid: currentUser.uid,
      followerUsername: currentUserDisplayName,
      targetUid: targetUserUID,
    );

    fetchAllUsers();
  }

  Future<void> unfollowUser(String targetUserUID) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) throw Exception();

    await firebaseFunctionsSource.unfollowUser(
      followerUid: currentUser.uid,
      targetUid: targetUserUID,
    );

    fetchAllUsers();
  }
}
