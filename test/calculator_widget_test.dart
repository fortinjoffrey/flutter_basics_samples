import 'package:basics_samples/calculator_wiget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'should display result of the sum of two numbers',
    (tester) async {
      final widget = MaterialApp(
        home: Scaffold(
          body: CalculatorWidget(),
        ),
      );

      final aNumberTextFieldFinder = find.byKey(const Key('calculator-a-number-textfield'));
      final bNumberTextFieldFinder = find.byKey(const Key('calculator-b-number-textfield'));

      await tester.pumpWidget(widget);

      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);

      await tester.enterText(aNumberTextFieldFinder, '2');
      await tester.enterText(bNumberTextFieldFinder, '4');

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('6'), findsOneWidget);
    },
  );
}
