import 'package:basics_samples/confirm_field/confirm_field_state.dart';
import 'package:bloc/bloc.dart';

typedef FieldValidator = String? Function(String);
typedef FieldValidatorExtra<T> = String? Function(String, T);

class ConfirmFieldCubit<T> extends Cubit<ConfirmFieldState> {
  static const String defaultNonCorrespondingErrorMsg = 'Both fields are not equal';

  final FieldValidator? fieldValidator;
  final FieldValidatorExtra<T>? fieldValidatorExtra;
  final String? nonCorrespondingErrorMsg;
  T? extra;

  ConfirmFieldCubit({
    this.fieldValidator,
    this.fieldValidatorExtra,
    this.nonCorrespondingErrorMsg = defaultNonCorrespondingErrorMsg,
    this.extra,
  })  : assert(fieldValidator != null && fieldValidatorExtra == null ||
            fieldValidator == null && fieldValidatorExtra != null),
        assert(fieldValidator != null || (fieldValidatorExtra != null && extra != null)),
        super(
          ConfirmFieldState(
            fieldErrorMsg: null,
            confirmFieldErrorMsg: null,
          ),
        );

  void setExtra(T newExtra) {
    extra = newExtra;
    onFieldChanged(state.field);
    onConfirmFieldChanged(state.confirmField);
  }

  void onFieldChanged(String newFieldValue) {
    String? emailValidationResult;
    bool isEmailValid = false;
    bool isConfirmFieldValid = false;

    if (fieldValidator != null) {
      emailValidationResult = fieldValidator!(newFieldValue);
    } else if (fieldValidatorExtra != null) {
      emailValidationResult = fieldValidatorExtra!(newFieldValue, extra!);
    } else {
      throw 'Missing at least one validator';
    }

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

    // validationResult = fieldValidator(confirmField);
    // if (extra != null) {
    //   validationResult = fieldValidator(confirmField, extra!);
    // } else {
    //   validationResult = fieldValidator(confirmField);
    // }

    if (fieldValidator != null) {
      validationResult = fieldValidator!(confirmField);
    } else if (fieldValidatorExtra != null) {
      validationResult = fieldValidatorExtra!(confirmField, extra!);
    } else {
      throw 'Missing at least one validator';
    }

    if (validationResult == null && !isEqualToEmail) validationResult = nonCorrespondingErrorMsg;

    return validationResult;
  }
}
