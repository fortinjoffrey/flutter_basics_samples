import 'package:dio/dio.dart';
import 'package:flutter_basics_samples/core/network/dio_request_canceller.dart';
import 'package:flutter_basics_samples/core/network/models/request_key.dart';
import 'package:flutter_basics_samples/flows/posts/data/sources/contracts/fetch_post_source.dart';
import 'package:flutter_basics_samples/flows/posts/data/sources/contracts/fetch_posts_source.dart';
import 'package:flutter_basics_samples/flows/posts/data/sources/jsonplaceholder_api_source/dtos/post_dto.dart';
import 'package:flutter_basics_samples/flows/posts/domain/entities/post.dart';

final class JsonPlaceholderApiSource implements FetchPostsSource, FetchPostSource {
  final Dio dio;
  final RequestCanceller requestCanceller;

  JsonPlaceholderApiSource()
      : dio = Dio(BaseOptions(
          baseUrl: 'https://jsonplaceholder.typicode.com',
        )),
        requestCanceller = RequestCanceller();

  static final _fetchPostsKey = RequestKey(name: 'fetchPosts');
  static final _fetchPostKey = RequestKey(name: 'fetchPost');

  @override
  Future<List<Post>> fetchPosts() async {
    final cancelToken = requestCanceller.create(_fetchPostsKey);
    final response = await dio.get('/posts', cancelToken: cancelToken);
    return response.data.map((e) => PostDto.fromJson(e).toEntity()).toList();
  }

  @override
  void cancelFetchPosts() {
    requestCanceller.cancel(_fetchPostsKey);
  }

  @override
  Future<Post> fetchPost(int id) async {
    final cancelToken = requestCanceller.create(_fetchPostKey);
    final response = await dio.get('/posts/$id', cancelToken: cancelToken);
    return PostDto.fromJson(response.data).toEntity();
  }

  @override
  void cancelFetchPost(int id) {
    requestCanceller.cancel(_fetchPostKey);
  }
}
