import 'package:json_annotation/json_annotation.dart';

import 'child.dart';

part 'father.g.dart';

// If true, generated toJson methods will explicitly call toJson on nested objects.
@JsonSerializable(explicitToJson: true)
class Father {
  Father(this.name, this.child);

  final String name;
  final Child child;

  @override
  String toString() {
    return 'Father(name: $name, child: $child)';
  }

  factory Father.fromJson(Map<String, dynamic> json) => _$FatherFromJson(json);

  Map<String, dynamic> toJson() => _$FatherToJson(this);
}
