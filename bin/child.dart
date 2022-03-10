import 'package:freezed_annotation/freezed_annotation.dart';

part 'child.freezed.dart';
part 'child.g.dart';

@freezed
class Child with _$Child {
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory Child({
    required String name,
  }) = _Child;

  factory Child.fromJson(Map<String, dynamic> json) => _$ChildFromJson(json);
}
