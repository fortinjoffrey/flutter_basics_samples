import 'package:flutter_basics_samples/flows/posts/data/sources/contracts/fetch_post_source.dart';
import 'package:flutter_basics_samples/flows/posts/data/sources/contracts/fetch_posts_source.dart';
import 'package:flutter_basics_samples/flows/posts/domain/entities/post.dart';

final class PostRepository {
  final FetchPostsSource fetchPostsSource;
  final FetchPostSource fetchPostSource;

  PostRepository({
    required this.fetchPostsSource,
    required this.fetchPostSource,
  });

  Future<List<Post>> fetchPosts() async {
    return fetchPostsSource.fetchPosts();
  }

  Future<Post> fetchPost(int id) async {
    return fetchPostSource.fetchPost(id);
  }

  void cancelFetchPosts() {
    fetchPostsSource.cancelFetchPosts();
  }

  void cancelFetchPost(int id) {
    fetchPostSource.cancelFetchPost(id);
  }
}
