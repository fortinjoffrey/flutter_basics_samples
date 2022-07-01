import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TextField keyboard navigation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: KeyboardActions(
          config: KeyboardActionsConfig(
            nextFocus: true,
            actions: [
              KeyboardActionsItem(
                focusNode: _emailFocusNode,
              ),
              KeyboardActionsItem(
                focusNode: _passwordFocusNode,
              ),
              KeyboardActionsItem(
                focusNode: _phoneNumberFocusNode,
              ),
            ],
          ),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  focusNode: _emailFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  onEditingComplete: () {
                    _passwordFocusNode.requestFocus();
                  },
                ),
                TextFormField(
                  focusNode: _passwordFocusNode,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  onEditingComplete: () {
                    _phoneNumberFocusNode.requestFocus();
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  focusNode: _phoneNumberFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Phone number',
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
