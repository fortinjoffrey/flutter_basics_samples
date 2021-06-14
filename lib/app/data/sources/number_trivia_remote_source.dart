import 'dart:convert';

import 'package:basics_samples/app/data/dtos/number_trivia_dto.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';

class NumberTriviaRemoteSource {
  NumberTriviaRemoteSource({required http.Client client}) : _client = client;

  final http.Client _client;

  Future<NumberTriviaDto> getConcreteNumberTrivia(int number) async {
    final response = await _client.get(
      Uri.parse('http://numbersapi.com/$number'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return NumberTriviaDto.fromJson(json.decode(response.body) as Map<String, dynamic>);
    } else {
      throw ServerException();
    }
  }
}
