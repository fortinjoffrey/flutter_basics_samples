import 'package:basics_samples/confirm_field/confirm_field_form.dart';
import 'package:basics_samples/validators/email_validator.dart';
import 'package:basics_samples/validators/password_validator.dart';
import 'package:flutter/material.dart';

class ConfirmEmailScreen extends StatelessWidget {
  const ConfirmEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm email screen'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              ConfirmFieldForm(label: 'E-mail', fieldValidator: validateEmail),
              ConfirmFieldForm(label: 'Passowrd', fieldValidator: validatePassword)
            ],
          ),
        ),
      ),
    );
  }
}
