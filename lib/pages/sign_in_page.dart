import 'package:basics_samples/cubits/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FormCategory { signIn, signUp }

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String _email = '';
  String _password = '';
  String _username = '';

  FormCategory formCategory = FormCategory.signIn;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onDoubleTap: () {
            setState(() {
              _email = 'test@gmail.com';
              _emailController.text = _email;
              // _emailController.value = TextEditingValue(text:_email);
              _password = 'test1234';
              _passwordController.text = _password;
            });
          },
          child: Text('Sign in page'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _emailController,
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  label: Text('E-mail'),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _passwordController,
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  label: Text('Password'),
                ),
              ),
            ),
            if (formCategory == FormCategory.signUp)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      _username = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                    label: Text('Username'),
                  ),
                ),
              ),
            if (formCategory == FormCategory.signIn) ...[
              ElevatedButton(
                onPressed: enableLoginButton
                    ? () {
                        context.read<AuthCubit>().signIn(_email, _password);
                      }
                    : null,
                child: const Text('Sign in'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    formCategory = FormCategory.signUp;
                  });
                },
                child: const Text('No account? Sign up'),
              ),
            ],
            if (formCategory == FormCategory.signUp) ...[
              ElevatedButton(
                onPressed: enableLoginButton
                    ? () {
                        context.read<AuthCubit>().signUp(
                              email: _email,
                              password: _password,
                              username: _username,
                            );
                      }
                    : null,
                child: const Text('Sign up'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    formCategory = FormCategory.signIn;
                  });
                },
                child: const Text('Already have an account? Sign in'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  bool get enableLoginButton {
    return _email.isNotEmpty == true && _password.isNotEmpty == true;
  }
}
