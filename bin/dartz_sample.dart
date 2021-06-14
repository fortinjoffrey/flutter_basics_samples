import 'package:dartz/dartz.dart';

void main() {
  print(isNumberPositive(3));
  print(isNumberPositive(-1));
  print(isNumberPositive('toto'));

  isNumberPositive('toto').fold(
    (failure) => print(failure.message),
    (value) => print(value),
  );

  final userId = getUserId('James');
  userId.fold(
    (failure) => print(failure.message),
    (id) => print(id),
  );
}

class Failure {
  Failure({required this.message});
  final String message;
}

Either<Failure, bool> isNumberPositive(dynamic number) {
  if (number is num) {
    return Right(number > 0);
  }
  return Left(Failure(message: 'Type is not a num'));
}

Either<Failure, int> getUserId(String username) {
  if (username == 'Gordon') {
    return Right(123);
  }
  return Left(Failure(message: 'Username not found'));
}
