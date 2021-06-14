import 'package:basics_samples/app/domain/contracts/repository.dart';
import 'package:basics_samples/app/domain/entities/number_trivia.dart';
import 'package:basics_samples/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class NumberTriviaRepository implements Repository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
}
