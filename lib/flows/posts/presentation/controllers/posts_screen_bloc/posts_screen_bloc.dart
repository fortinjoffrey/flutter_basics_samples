import 'package:bloc/bloc.dart';
import 'package:flutter_basics_samples/flows/posts/domain/usecases/fetch_posts.dart';
import 'package:flutter_basics_samples/flows/posts/presentation/controllers/posts_screen_bloc/posts_screen_event.dart';
import 'package:flutter_basics_samples/flows/posts/presentation/controllers/posts_screen_bloc/posts_screen_state.dart';

class PostsScreenBloc extends Bloc<PostsScreenEvent, PostsScreenState> {
  final FetchUserPosts fetchUserPosts;
  PostsScreenBloc({required this.fetchUserPosts}) : super(const PostsScreenState()) {
    on<PostsScreenEvent>((event, emit) {
      switch (event) {
        case FetchPosts():
          _onFetchPosts(event, emit);
          break;
      }
    });
  }

  Future<void> _onFetchPosts(FetchPosts event, Emitter<PostsScreenState> emit) async {
    fetchUserPosts.cancel();
    final posts = await fetchUserPosts.call(null);
    emit(state.copyWith(posts: posts));
  }
}
