import 'package:basics_samples/counter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Counter', () {
    Counter counter = Counter();

    setUp(() {
      counter = Counter();
    });

    test('value should start at 0', () {
      expect(counter.value, 0);
    });

    test('value should be incremented', () {
      counter.increment();

      expect(counter.value, 1);
    });

    test('value should be decremented', () {
      counter.decrement();

      expect(counter.value, -1);
    });
  });
}
