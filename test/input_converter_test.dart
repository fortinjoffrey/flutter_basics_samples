import 'package:basics_samples/core/error/failures.dart';
import 'package:basics_samples/core/utils/input_converter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

/// 3 tests:
/// The InputConverter should return an int when the string is an unsigned int
/// The InputConverter should return a Failure if the string is not an int
/// The InputConverter should return a Failure if the string is a negative int

void main() {
  late InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringToUnsignedInt', () {
    test(
      'should return an integer when the string represents an unsigned integer',
      () async {
        // arrange
        const str = '123';

        // act
        final result = inputConverter.stringToUnsignedInteger(str);

        // assert
        expect(result, const Right<Failure, int>(123));
      },
    );

    test(
      'should return a Failure when the string is not an integer',
      () async {
        // arrange
        const str = 'abc';
        // act
        final result = inputConverter.stringToUnsignedInteger(str);

        // assert
        expect(result, Left<Failure, int>(InvalidInputFailure()));
      },
    );

    test(
      'should return a Failure when the string is a negative integer',
      () async {
        // arrange
        const str = '-123';
        // act
        final result = inputConverter.stringToUnsignedInteger(str);
        // assert
        expect(result, Left<Failure, int>(InvalidInputFailure()));
      },
    );
  });
}
