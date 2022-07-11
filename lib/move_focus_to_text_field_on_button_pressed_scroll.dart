import 'package:flutter/material.dart';

@immutable
class MoveFocusToTextFieldOnButtonPressedScroll extends StatefulWidget {
  const MoveFocusToTextFieldOnButtonPressedScroll({Key? key}) : super(key: key);

  @override
  State<MoveFocusToTextFieldOnButtonPressedScroll> createState() => _MoveFocusToTextFieldOnButtonPressedScrollState();
}

class _MoveFocusToTextFieldOnButtonPressedScrollState extends State<MoveFocusToTextFieldOnButtonPressedScroll> {
  final textfield1focusNode = FocusNode();

  final textfield2focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Try accessibility focus move'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
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
                SizedBox(
                  height: MediaQuery.of(context).size.height/2,
                ),
                Text('Dummy Text'),
                SizedBox(
                  height: MediaQuery.of(context).size.height/2,
                ),
                TextButton(
                  onPressed: () {
                    textfield1focusNode.requestFocus();
                  },
                  child: const Text('Set focus'),
                ),
                  SizedBox(
                  height: MediaQuery.of(context).size.height,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
