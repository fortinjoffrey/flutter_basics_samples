import 'package:freezed_annotation/freezed_annotation.dart';

part 'posts_screen_event.freezed.dart';

@freezed
sealed class PostsScreenEvent with _$PostsScreenEvent {
  const factory PostsScreenEvent.fetchPosts() = FetchPosts;
}
