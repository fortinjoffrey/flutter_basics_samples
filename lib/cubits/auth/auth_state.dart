import 'package:basics_samples/models/app_user.dart';
import 'package:flutter/foundation.dart';

@immutable
class AuthState {
  final AppUser? currentUser;

  AuthState({required this.currentUser});
}
