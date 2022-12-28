import 'package:basics_samples/confirm_field/confirm_field_state.dart';
import 'package:bloc/bloc.dart';

typedef FieldValidator = String? Function(String);

class ConfirmFieldCubit extends Cubit<ConfirmFieldState> {
  static const String defaultNonCorrespondingErrorMsg = 'Both fields are not equal';

  final FieldValidator fieldValidator;
  final String? nonCorrespondingErrorMsg;

  ConfirmFieldCubit({
    required this.fieldValidator,
    this.nonCorrespondingErrorMsg = defaultNonCorrespondingErrorMsg,
  }) : super(
          ConfirmFieldState(
            fieldErrorMsg: null,
            confirmFieldErrorMsg: null,
          ),
        );

  void onFieldChanged(String newFieldValue) {
    String? emailValidationResult;
    bool isEmailValid = false;
    bool isConfirmFieldValid = false;

    emailValidationResult = fieldValidator(newFieldValue);
    if (emailValidationResult == null) isEmailValid = true;

    String? confirmFieldValidationResult = state.confirmFieldErrorMsg;
    if (state.confirmField.isNotEmpty) {
      confirmFieldValidationResult = validateConfirmField(state.confirmField, newFieldValue);
      if (confirmFieldValidationResult == null) isConfirmFieldValid = true;
    }

    emit(state.copyWith(
      field: newFieldValue,
      fieldErrorMsg: emailValidationResult,
      confirmFieldErrorMsg: confirmFieldValidationResult,
      isFieldValid: isEmailValid,
      isConfirmFieldValid: isConfirmFieldValid,
    ));
  }

  void onConfirmFieldChanged(String confirmField) {
    final validationResult = validateConfirmField(confirmField, state.field);
    bool isConfirmFieldValid = false;

    if (validationResult == null) isConfirmFieldValid = true;

    emit(
      state.copyWith(
        confirmFieldErrorMsg: validationResult,
        confirmField: confirmField,
        isConfirmFieldValid: isConfirmFieldValid,
      ),
    );
  }

  String? validateConfirmField(String confirmField, String email) {
    final bool isEqualToEmail = confirmField == email;

    String? validationResult;

    validationResult = fieldValidator(confirmField);

    if (validationResult == null && !isEqualToEmail) validationResult = nonCorrespondingErrorMsg;

    return validationResult;
  }
}
