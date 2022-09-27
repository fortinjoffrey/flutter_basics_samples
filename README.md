## testWidgets of a widget that uses setState

### calculator_widget_test.dart

```dart
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
```

### UI under test

<img src="https://user-images.githubusercontent.com/36731875/192634855-559fba7e-5120-4c5c-9040-10252ecf3576.png" width="35%"/>
