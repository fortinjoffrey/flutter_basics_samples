import 'package:flutter_basics_samples/flows/posts/domain/entities/post.dart';

abstract class FetchPostSource {
  Future<Post> fetchPost(int id);
  void cancelFetchPost(int id);
}
