import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String uid;
  final String username;
  final List<String> followings;
  final List<String> followers;

  const AppUser({
    required this.uid,
    required this.username,
    required this.followings,
    required this.followers,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      uid: json['uid'] as String,
      username: json['username'] as String,
      followings: List<String>.from(json['followings']),
      followers: List<String>.from(json['followers']),
    );
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
        uid,
        username,
        followings,
        followers,
      ];
}
