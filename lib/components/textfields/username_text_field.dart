import 'package:basics_samples/components/textfields/primary_text_field.dart';
import 'package:basics_samples/components/textfields/validators.dart';
import 'package:flutter/material.dart';

typedef ValueValidationChanged = void Function(String, bool);

class UsernameTextField extends StatefulWidget {
  const UsernameTextField({
    super.key,
    this.onChanged,
  });

  final ValueValidationChanged? onChanged;

  @override
  State<UsernameTextField> createState() => _UsernameTextFieldState();
}

class _UsernameTextFieldState extends State<UsernameTextField> {
  final GlobalKey<FormFieldState> _key = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return PrimaryTextField(
      fieldKey: _key,
      labelText: 'Username',
      // hintText: 'Username',
      onChanged: (value) {
        if (_key.currentState == null) return;
        final isValid = _key.currentState!.validate();
        widget.onChanged?.call(value, isValid);
      },
      validator: Validators.validateUsername,
    );
  }
}
