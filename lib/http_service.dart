import 'dart:convert';
import 'package:http/http.dart' as http;

import 'album.dart';

class HttpService {
  Future<Album> fetchAlbum() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
