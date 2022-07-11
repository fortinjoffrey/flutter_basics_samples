import 'package:flutter/material.dart';


class TryAccessibilityFocusMove extends StatefulWidget {
  const TryAccessibilityFocusMove({Key? key,}) : super(key: key);


  @override
  _TryAccessibilityFocusMoveState createState() => _TryAccessibilityFocusMoveState();
}

class _TryAccessibilityFocusMoveState extends State<TryAccessibilityFocusMove> {
  bool focused = false;
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Semantics(
                  focusable: true,
                  focused: focused,
                  child: TextFormField(
                    onEditingComplete: () {
                      textfield2focusNode.requestFocus();
                    },
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
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Semantics(
                  focused: textfield2focusNode.hasFocus,
                  child: TextFormField(
                    
                    focusNode: textfield2focusNode,
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
              ),
              TextButton(
                onPressed: () {
                  textfield1focusNode.requestFocus();
                },
                child: const Text('Set focus'),
              ),
              SizedBox(
                height: 600,
                child: Center(child: const Text('Scroll down'),),
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
