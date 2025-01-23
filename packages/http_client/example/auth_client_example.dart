import 'package:core_http_client/http_client.dart';

class AuthTokenProvider implements TokenProvider {
  @override
  String get token => 'invalid_token'; 
}

class GithubApiProvider implements BaseUrlProvider {
  @override
  String get baseUrl => 'https://api.github.com';
}

class Repository {
  final int id;
  final String name;
  final String fullName;
  final bool private;
  final String? description;

  Repository({
    required this.id,
    required this.name,
    required this.fullName,
    required this.private,
    this.description,
  });

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      id: json['id'] as int,
      name: json['name'] as String,
      fullName: json['full_name'] as String,
      private: json['private'] as bool,
      description: json['description'] as String?,
    );
  }

  @override
  String toString() => 'Repository(id: $id, name: $name, private: $private)';
}

void main() async {
  final client = CoreHttpClientFactory.create(
    tokenProvider: AuthTokenProvider(),
    baseUrlProvider: GithubApiProvider(),
    observer: CoreHttpObserver(),
  );

  try {
    await client.get<List<dynamic>, List<Repository>>(
      '/user/repos',
      builder: (data) => data.map((json) => Repository.fromJson(json as Map<String, dynamic>)).toList(),
      authorizationNeeded: true,
    );
  } on CoreHttpClientException catch (e) {
    if (e.statusCode == 401) {
      print('Unauthorized');
    }
  }

  try {
    final publicRepo = await client.get<Map<String, dynamic>, Repository>(
      '/repos/flutter/flutter',
      builder: Repository.fromJson,
      authorizationNeeded: false,
    );
    print(publicRepo);
  } on CoreHttpClientException catch (e) {
    print(e);
  }
} 