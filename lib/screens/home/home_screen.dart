import 'package:basics_samples/validators.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormFieldState> _emailFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _lastAndFirstNameKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _passwordKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TextField validators'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('This field must contain a valid email adress'),
                const SizedBox(height: 8),
                TextFormField(
                  key: _emailFieldKey,
                  onChanged: (value) {
                    _emailFieldKey.currentState?.validate();
                  },
                  validator: Validators.validateEmail,
                  decoration: InputDecoration(
                    label: const Text('Email'),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('This field must contain two words separated by a space'),
                const SizedBox(height: 8),
                TextFormField(
                  key: _lastAndFirstNameKey,
                  onChanged: (value) {
                    _lastAndFirstNameKey.currentState?.validate();
                  },
                  validator: Validators.validateTwoWords,
                  decoration: InputDecoration(
                    label: const Text('First and Last name'),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  '''This field must contain at least:
- At least 8 characters
- At least 1 letter
- At least 1 symbol
- At least 1 number
                ''',
                ),
                const SizedBox(height: 8),
                TextFormField(
                  key: _passwordKey,
                  onChanged: (value) {
                    _passwordKey.currentState?.validate();
                  },
                  validator: Validators.validatePassword,
                  decoration: InputDecoration(
                    label: const Text('Password'),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
