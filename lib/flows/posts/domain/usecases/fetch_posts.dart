import 'package:flutter_basics_samples/core/domain/cancellable.dart';
import 'package:flutter_basics_samples/core/domain/use_case.dart';
import 'package:flutter_basics_samples/flows/posts/data/repositories/post_repository.dart';
import 'package:flutter_basics_samples/flows/posts/domain/entities/post.dart';

class FetchUserPosts implements UseCase<List<Post>, void>, Cancellable {
  final PostRepository postRepository;

  FetchUserPosts({required this.postRepository});

  @override
  Future<List<Post>> call(void params) async {
    return postRepository.fetchPosts();
  }

  @override
  void cancel() {
    postRepository.cancelFetchPosts();
  }
}
