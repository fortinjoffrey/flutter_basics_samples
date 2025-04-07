import 'package:flutter_basics_samples/flows/posts/domain/entities/post.dart';

abstract class FetchPostsSource {
  Future<List<Post>> fetchPosts();
  void cancelFetchPosts();
}
