import 'package:basics_samples/auth/auth_provider.dart';
import 'package:basics_samples/components/textfields/email_text_field.dart';
import 'package:basics_samples/components/textfields/password_text_field.dart';
import 'package:basics_samples/components/textfields/username_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    required this.authProvider,
    required this.onSuccess,
  });

  final AuthProvider authProvider;
  final VoidCallback onSuccess;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  String _email = '';
  String _username = '';
  String _password = '';
  bool _isEmailValid = false;
  bool _isUsernameValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onDoubleTap: () {
                    setState(() {
                      _email = 'testX@gmail.com';
                      _password = 'test1234';
                      _username = 'testX';
                      _isEmailValid = true;
                      _isUsernameValid = true;
                    });
                  },
                  child: Text(
                    'Sign up with email',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                const SizedBox(height: 16),
                UsernameTextField(onChanged: (value, isFieldValid) {
                  setState(() {
                    _username = value;
                    _isUsernameValid = isFieldValid;
                  });
                }),
                const SizedBox(height: 16),
                EmailTextField(
                  onChanged: (value, isFieldValid) {
                    setState(() {
                      _email = value;
                      _isEmailValid = isFieldValid;
                    });
                  },
                ),
                const SizedBox(height: 16),
                PasswordTextField(
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _isEmailValid && _isUsernameValid
                      ? () async {
                          _email = _email.trim();
                          _password = _password.trim();
                          _username = _username.trim();

                          try {
                            final userCredential = await widget.authProvider.signUp(
                              email: _email.trim(),
                              password: _password.trim(),
                            );

                            userCredential.user?.updateDisplayName(_username);

                            widget.onSuccess();
                          } catch (e) {
                            String errorMessage = 'An error occured';

                            if (e is FirebaseAuthException) {
                              if (e.message != null) errorMessage = e.message!;
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(errorMessage)),
                            );
                          }
                        }
                      : null,
                  child: Text('Sign up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
