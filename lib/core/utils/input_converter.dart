import 'package:dartz/dartz.dart';

import '../error/failures.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String str) {
    final integer = int.tryParse(str);

    return (integer == null || integer.isNegative) ? Left(InvalidInputFailure()) : Right(int.parse(str));
  }
}
