// ignore_for_file: unused_local_variable
import 'package:core_http_client/http_client.dart';

class SimpleTokenProvider implements TokenProvider {
  @override
  String get token => '';
}

class JsonPlaceholderUrlProvider implements BaseUrlProvider {
  @override
  String get baseUrl => 'https://jsonplaceholder.typicode.com';
}

class Post {
  final int id;
  final int userId;
  final String title;
  final String body;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      userId: json['userId'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
    };
  }

  @override
  String toString() => 'Post(id: $id, userId: $userId, title: $title)';
}

// void initDependencies() {

//   final getIt = GetIt.instance;

//   getIt.registerFactory<HttpClient>(() => CoreHttpClient(
//     tokenProvider: SimpleTokenProvider(),
//     baseUrlProvider: JsonPlaceholderUrlProvider(),
//     logger: CoreHttpLogger(),
//   ); )

// }

// abstract class UseCase<T,P> {}

// class GetUser extends UseCase<String, String> {
//   Future<String> call([String id]) {
//     final client = getIt<HttpClient>();
//   }
// }


void main() async {
  final client = CoreHttpClient(
    tokenProvider: SimpleTokenProvider(),
    baseUrlProvider: JsonPlaceholderUrlProvider(),
    interceptor: CoreHttpLoggerInterceptor(),
  );

  try {
    final post = await client.get<Map<String, dynamic>, Post>(
      '/posts/1',
      builder: Post.fromJson,
      authorizationNeeded: false,
    );

    final userPosts = await client.get<List<dynamic>, List<Post>>(
      '/posts',
      queryParameters: {'userId': 1},
      builder: (data) => data.map((json) => Post.fromJson(json as Map<String, dynamic>)).toList(),
      authorizationNeeded: false,
    );

    final newPost = await client.post<Map<String, dynamic>, Post>(
      '/posts',
      data: {
        'title': 'foo',
        'body': 'bar',
        'userId': 1,
      },
      builder: Post.fromJson,
      authorizationNeeded: false,
    );

    final updatedPost = await client.put<Map<String, dynamic>, Post>(
      '/posts/1',
      data: {
        'id': 1,
        'title': 'Updated title',
        'body': 'Updated body',
        'userId': 1,
      },
      builder: Post.fromJson,
      authorizationNeeded: false,
    );

    final patchedPost = await client.patch<Map<String, dynamic>, Post>(
      '/posts/1',
      data: {
        'title': 'Patched title',
      },
      builder: Post.fromJson,
      authorizationNeeded: false,
    );

    await client.delete<Map<String, dynamic>, void>(
      '/posts/1',
      builder: (_) {},
      authorizationNeeded: false,
    );
  } catch (e) {
    print(e);
  }

}
