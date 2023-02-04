import 'package:basics_samples/components/textfields/primary_text_field.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    this.onChanged,
  });

  final ValueChanged<String>? onChanged;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return PrimaryTextField(
      labelText: 'Password',
      onChanged: widget.onChanged,
      obscureText: obscureText,
      suffixIcon: InkWell(
        onTap: () => setState(() {
          obscureText = !obscureText;
        }),
        child: Icon(!obscureText ? Icons.visibility : Icons.visibility_off,color: Colors.white),
      ),
    );
  }
}
