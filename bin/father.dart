import 'package:freezed_annotation/freezed_annotation.dart';

import 'child.dart';

part 'father.freezed.dart';
part 'father.g.dart';

@freezed
// If true, generated toJson methods will explicitly call toJson on nested objects.
class Father with _$Father {
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory Father({
    required String name,
    required Child child,
  }) = _Father;

  factory Father.fromJson(Map<String, dynamic> json) => _$FatherFromJson(json);
}
