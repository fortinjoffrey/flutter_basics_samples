import 'package:flutter/material.dart';

@immutable
class MoveFocusToTextFieldOnButtonPressed extends StatefulWidget {
   const MoveFocusToTextFieldOnButtonPressed({Key? key}) : super(key: key);

  @override
  State<MoveFocusToTextFieldOnButtonPressed> createState() => _MoveFocusToTextFieldOnButtonPressedState();
}

class _MoveFocusToTextFieldOnButtonPressedState extends State<MoveFocusToTextFieldOnButtonPressed> {
  final textfield1focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Try accessibility focus move'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  focusNode: textfield1focusNode,
                  decoration: InputDecoration(
                    labelText: 'TextField',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  textfield1focusNode.requestFocus();
                },
                child: const Text('Set focus'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}