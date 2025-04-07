import 'package:flutter_basics_samples/core/domain/cancellable.dart';
import 'package:flutter_basics_samples/core/domain/use_case.dart';
import 'package:flutter_basics_samples/flows/posts/data/repositories/post_repository.dart';
import 'package:flutter_basics_samples/flows/posts/domain/entities/post.dart';

class FetchPost implements UseCase<Post, int>, Cancellable {
  final PostRepository postRepository;

  FetchPost({required this.postRepository});

  @override
  Future<Post> call(int id) async {
    return postRepository.fetchPost(id);
  }

  @override
  void cancel() {
    postRepository.cancelFetchPost(1);
  }
}
