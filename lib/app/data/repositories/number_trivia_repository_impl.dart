import 'package:basics_samples/app/data/dtos/number_trivia_dto.dart';
import 'package:basics_samples/app/data/sources/number_trivia_remote_source.dart';
import 'package:basics_samples/app/domain/contracts/number_trivia_repository.dart';
import 'package:basics_samples/app/domain/entities/number_trivia.dart';
import 'package:basics_samples/core/error/exceptions.dart';
import 'package:basics_samples/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteSource _remoteSource;

  NumberTriviaRepositoryImpl({
    required NumberTriviaRemoteSource remoteSource,
  }) : _remoteSource = remoteSource;

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number) async {
    try {
      final remoteTriviaDto = await _remoteSource.getConcreteNumberTrivia(number);
      return Right(remoteTriviaDto.toDomain());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
