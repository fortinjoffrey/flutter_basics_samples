import 'package:flutter_basics_samples/flows/posts/domain/entities/post.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_dto.freezed.dart';
part 'post_dto.g.dart';

@freezed
abstract class PostDto with _$PostDto {
  @JsonSerializable(explicitToJson: true)
  const factory PostDto({
    required int id,
    required int userId,
    required String title,
    required String body,
  }) = _PostDto;

  factory PostDto.fromJson(Map<String, dynamic> json) => _$PostDtoFromJson(json);
}

extension PostDtoX on PostDto {
  Post toEntity() => Post(id: id, title: title, body: body);
}
