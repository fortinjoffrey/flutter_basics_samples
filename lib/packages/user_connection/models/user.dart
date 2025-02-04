import 'dart:convert';

import 'package:flutter/foundation.dart';

class User {
  final List<String> vehicleIds;
  final String id;
  final String email;

  const User({
    required this.vehicleIds,
    required this.id,
    required this.email,
  });

  User copyWith({
    List<String>? vehicleIds,
    String? id,
    String? email,
  }) {
    return User(
      vehicleIds: vehicleIds ?? this.vehicleIds,
      id: id ?? this.id,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'vehicleIds': vehicleIds});
    result.addAll({'id': id});
    result.addAll({'email': email});
    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      vehicleIds: List<String>.from(map['vehicleIds']),
      id: map['id'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() => 'User(vehicleIds: $vehicleIds, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is User &&
      listEquals(other.vehicleIds, vehicleIds) &&
      other.id == id &&
      other.email == email;
  }

  @override
  int get hashCode => vehicleIds.hashCode ^ id.hashCode ^ email.hashCode;
}
