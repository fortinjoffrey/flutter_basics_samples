import 'package:flutter/material.dart';

class PrimaryTextField extends StatelessWidget {
  const PrimaryTextField({
    super.key,
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.onChanged,
    this.initialValue,
    this.textInputAction,
    this.controller,
    this.enabled,
    this.validator,
    this.onFieldSubmitted,
    this.readOnly = false,
    this.maxLines = 1,
    this.obscureText = false,
    this.suffixIcon,
  });

  final Key? fieldKey;
  final String? hintText;
  final String? labelText;
  final bool? enabled;
  final bool readOnly;

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? initialValue;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final int? maxLines;
  final bool obscureText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: fieldKey,
      style: Theme.of(context).textTheme.bodyMedium,
      controller: controller,
      enabled: enabled,
      readOnly: readOnly,
      validator: validator,
      onChanged: onChanged,
      obscureText: obscureText,
      initialValue: initialValue,
      textInputAction: textInputAction,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        floatingLabelStyle: TextStyle(color: Colors.white),
        suffixIcon: suffixIcon,
        hintText: hintText,
        filled: true,
        fillColor: readOnly ? Theme.of(context).colorScheme.surface : Theme.of(context).colorScheme.background,
        border: const OutlineInputBorder(
          borderSide: BorderSide(width: 0, style: BorderStyle.none),
          gapPadding: 0,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }
}
