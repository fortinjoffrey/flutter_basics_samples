import 'package:dartz/dartz.dart';

class Failure {
  const Failure({required this.message});
  final String message;

  @override
  String toString() => message;
}

Either<Failure, bool> isNumberPositive(dynamic number) {
  if (number is num) {
    return Right(number > 0);
  }
  return Left(Failure(message: 'Type is not a num'));
}

void main() {
  print(isNumberPositive(3));
  print(isNumberPositive(-1));
  print(isNumberPositive('1'));

  isNumberPositive('1').fold(
    (failure) => print(failure.message),
    (isPositive) => print(isPositive),
  );
}
