import 'package:freezed_annotation/freezed_annotation.dart';

part 'confirm_field_state.freezed.dart';

@freezed
class ConfirmFieldState with _$ConfirmFieldState {
  const factory ConfirmFieldState({
    @Default('') String field,
    @Default('') String confirmField,
    required String? fieldErrorMsg,
    required String? confirmFieldErrorMsg,
    @Default(false) bool isFieldValid,
    @Default(false) bool isConfirmFieldValid,
  }) = _ConfirmFieldState;
}

extension ConfirmFieldStateX on ConfirmFieldState {
  bool get isConfirmFormValid => isFieldValid && isConfirmFieldValid;
}
