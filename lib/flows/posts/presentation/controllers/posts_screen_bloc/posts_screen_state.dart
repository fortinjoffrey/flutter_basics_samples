import 'package:flutter_basics_samples/flows/posts/domain/entities/post.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'posts_screen_state.freezed.dart';

@freezed
abstract class PostsScreenState with _$PostsScreenState {
  const factory PostsScreenState({
    @Default([]) List<Post> posts,
  }) = _PostsScreenState;
}
