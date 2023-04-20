import 'dart:developer';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseFunctionsName {
  static const saveDeviceToken = 'saveDeviceToken';
  static const deleteDeviceToken = 'deleteDeviceToken';
  static const createUserData = 'createUserData';
  static const followUser = 'followUser';
  static const unfollowUser = 'unfollowUser';
}

class FirebaseFunctionsSource {
  final functions = FirebaseFunctions.instanceFor(region: 'europe-west3');

  Future<void> createUserData() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) throw Exception();

      final result = await functions.httpsCallable(FirebaseFunctionsName.createUserData).call({
        'uid': currentUser.uid,
        'displayName': currentUser.displayName,
      });
      log(result.data.toString());
    } on FirebaseFunctionsException catch (error) {
      log(error.toString());
      rethrow;
    }
  }

  Future<void> saveDeviceToken({
    required String deviceToken,
    required String platform,
  }) async {
    log('saveDeviceToken called\n deviceToken=$deviceToken\n platform=$platform\n\n');
    try {
      final result = await functions.httpsCallable(FirebaseFunctionsName.saveDeviceToken).call({
        'deviceToken': deviceToken,
        'platform': platform,
      });
      log(result.data.toString());
    } on FirebaseFunctionsException catch (error) {
      log(error.toString());
      rethrow;
    }
  }

  Future<void> deleteDeviceToken({
    required String deviceToken,
    required String idToken,
  }) async {
    log('saveDeviceToken called\n deviceToken=$deviceToken\n');
    try {
      final result = await functions.httpsCallable(FirebaseFunctionsName.deleteDeviceToken).call({
        'deviceToken': deviceToken,
        'idToken': idToken,
      });
      log(result.data.toString());
    } on FirebaseFunctionsException catch (error) {
      log(error.toString());
      rethrow;
    }
  }

  Future<void> followUser({
    required String followerUid,
    required String followerUsername,
    required String targetUid,
  }) async {
    try {
      final result = await functions.httpsCallable(FirebaseFunctionsName.followUser).call({
        'followerUid': followerUid,
        'followerUsername': followerUsername,
        'targetUid': targetUid,
      });
      log(result.data.toString());
    } on FirebaseFunctionsException catch (error) {
      log(error.toString());
      rethrow;
    }
  }

  Future<void> unfollowUser({
    required String followerUid,
    required String targetUid,
  }) async {
    try {
      final result = await functions.httpsCallable(FirebaseFunctionsName.unfollowUser).call({
        'followerUid': followerUid,
        'targetUid': targetUid,
      });
      log(result.data.toString());
    } on FirebaseFunctionsException catch (error) {
      log(error.toString());
      rethrow;
    }
  }
}
