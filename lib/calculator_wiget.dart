import 'package:flutter/material.dart';

class CalculatorWidget extends StatefulWidget {
  const CalculatorWidget({super.key});

  @override
  State<CalculatorWidget> createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  final aNumberController = TextEditingController();
  final bNumberController = TextEditingController();

  int? result;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('First number:'),
          TextField(
            key: Key('calculator-a-number-textfield'),
            controller: aNumberController,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
          ),
          Text('+'),
          Text('Second number:'),
          TextField(
            key: Key('calculator-b-number-textfield'),
            controller: bNumberController,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                result = int.parse(aNumberController.value.text) + int.parse(bNumberController.value.text);
              });
            },
            child: Text('Calculate'),
          ),
          if (result != null) Text('$result'),
        ],
      ),
    );
  }
}
