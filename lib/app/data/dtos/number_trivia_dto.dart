import 'package:equatable/equatable.dart';

import '../../domain/entities/number_trivia.dart';

class NumberTriviaDto extends Equatable {
  const NumberTriviaDto({
    required this.text,
    required this.number,
  });

  final String text;
  final int number;

  factory NumberTriviaDto.fromJson(Map<String, dynamic> json) => NumberTriviaDto(
        text: json['text'] as String,
        number: (json['number'] as num).toInt(),
      );

  @override
  List<Object?> get props => [text, number];
}

extension NumberTriviaDtoX on NumberTriviaDto {
  NumberTrivia toDomain() => NumberTrivia(text: text, number: number);
}
