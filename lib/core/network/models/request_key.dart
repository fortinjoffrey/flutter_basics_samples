import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_key.freezed.dart';

@freezed
abstract class RequestKey with _$RequestKey {
  const factory RequestKey({
    required String name,
    String? id,
  }) = _RequestKey;
}
