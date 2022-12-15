import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:json_annotation/json_annotation.dart';

// This doesn't exist yet...! See "Next Steps"
part 'user.g.dart';

/// A custom JsonSerializable annotation that supports decoding objects such
/// as Timestamps and DateTimes.
/// This variable can be reused between different models
const firestoreSerializable = JsonSerializable(
  converters: firestoreJsonConverters,
  // The following values could alternatively be set inside your `build.yaml`
  explicitToJson: true,
  createFieldMap: true,
);

@firestoreSerializable
class User {
  User({
    required this.id,
    required this.name,
    required this.age,
    required this.email,
  });

  @Id()
  final String id;

  final String name;
  final int age;
  final String email;
}

@Collection<User>('users')
final usersRef = UserCollectionReference();