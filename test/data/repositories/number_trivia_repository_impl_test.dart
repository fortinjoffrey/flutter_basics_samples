import 'package:basics_samples/app/data/dtos/number_trivia_dto.dart';
import 'package:basics_samples/app/data/repositories/number_trivia_repository_impl.dart';
import 'package:basics_samples/app/data/sources/number_trivia_remote_source.dart';
import 'package:basics_samples/app/domain/entities/number_trivia.dart';
import 'package:basics_samples/core/error/exceptions.dart';
import 'package:basics_samples/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'number_trivia_repository_impl_test.mocks.dart';
import 'package:mockito/annotations.dart';
// class MockRemoteSource extends Mock implements NumberTriviaRemoteSource {}

@GenerateMocks([NumberTriviaRemoteSource])
void main() {
  late NumberTriviaRepositoryImpl repositoryImpl;
  late MockNumberTriviaRemoteSource mockRemoteSource;

  setUp(() {
    mockRemoteSource = MockNumberTriviaRemoteSource();
    repositoryImpl = NumberTriviaRepositoryImpl(
      remoteSource: mockRemoteSource,
    );
  });

  group('getConcreteNumberTrivia', () {
    const tNumber = 1;
    const tNumberTriviaDto = NumberTriviaDto(text: 'Test Trivia', number: tNumber);
    const tNumberTrivia = NumberTrivia(text: 'Test Trivia', number: tNumber);

    test(
      'should return remote data when the call to remote source is successful',
      () async {
        // arrange
        when(mockRemoteSource.getConcreteNumberTrivia(any)).thenAnswer((_) async => tNumberTriviaDto);
        // act
        final result = await repositoryImpl.getConcreteNumberTrivia(tNumber);

        // assert
        // we verify that the mockRemoteSource.getConcreteNumberTrivia
        // has been called with tNumber and not something else
        verify(mockRemoteSource.getConcreteNumberTrivia(tNumber));
        expect(result, equals(const Right<dynamic, NumberTrivia>(tNumberTrivia)));
      },
    );

    test(
      'should return server failure when the call to remote source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteSource.getConcreteNumberTrivia(any)).thenThrow(ServerException());

        // act
        final result = await repositoryImpl.getConcreteNumberTrivia(tNumber);

        // assert
        verify(mockRemoteSource.getConcreteNumberTrivia(tNumber));
        expect(result, equals(Left<ServerFailure, dynamic>(ServerFailure())));
      },
    );
  });
}
