import 'package:basics_samples/components/textfields/primary_text_field.dart';
import 'package:basics_samples/components/textfields/validators.dart';
import 'package:flutter/material.dart';

typedef ValueValidationChanged = void Function(String, bool);

class EmailTextField extends StatefulWidget {
  const EmailTextField({
    super.key,
    this.initialValue,
    this.onChanged,
  });

  final String? initialValue;
  final ValueValidationChanged? onChanged;

  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  final GlobalKey<FormFieldState> _key = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return PrimaryTextField(
      fieldKey: _key,
      labelText: 'Email',
      initialValue: widget.initialValue,
      onChanged: (value) {
        if (_key.currentState == null) return;
        final isValid = _key.currentState!.validate();
        widget.onChanged?.call(value, isValid);
      },
      validator: Validators.validateEmail,
    );
  }
}
