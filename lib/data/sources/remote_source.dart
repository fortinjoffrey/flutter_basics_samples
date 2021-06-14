import 'package:basics_samples/domain/entities/user.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class RemoteSource {
  RemoteSource({required this.client});

  final http.Client client;

  Future<User> fetchUser() async {
    final response = await client.get(Uri.parse('https://jsonplaceholder.typicode.com/users/1'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return User.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load user');
    }
  }
}
