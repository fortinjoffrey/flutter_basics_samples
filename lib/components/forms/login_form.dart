import 'package:basics_samples/auth/auth_provider.dart';
import 'package:basics_samples/components/textfields/email_text_field.dart';
import 'package:basics_samples/components/textfields/password_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    required this.authProvider,
    required this.onSuccess,
  });

  final AuthProvider authProvider;
  final VoidCallback onSuccess;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String _email = '';
  String _password = '';
  bool _isEmailValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              GestureDetector(
                onDoubleTap: () {
                  setState(() {
                    _email = 'test@gmail.com';
                    _password = 'test1234';
                    _isEmailValid = true;
                  });
                },
                child: Text(
                  'Sign in with email',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
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
                onPressed: _isEmailValid
                    ? () async {
                        _email = _email.trim();
                        _password = _password.trim();

                        try {
                          await widget.authProvider.signInWithEmailAndPassword(
                            email: _email,
                            password: _password,
                          );

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
                child: Text('Sign in'),
              ),
              TextButton(
                onPressed: _isEmailValid
                    ? () {
                        widget.authProvider.forgotPassword(email: _email);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('A password reset link has been sent to $_email')),
                        );
                      }
                    : null,
                child: const Text('Forgot password?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
