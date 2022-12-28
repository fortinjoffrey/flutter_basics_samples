import 'package:basics_samples/confirm_field/confirm_field_cubit.dart';
import 'package:basics_samples/confirm_field/confirm_field_state.dart';
import 'package:basics_samples/validators/email_validator.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  // - invalidate field when email is invalid
  // - invalidate field when field has be emptied
  // - validate field when email is valid
  // - invalidate confirm field when original email differs from confirm field email

  blocTest<ConfirmFieldCubit, ConfirmFieldState>(
    'emits $ConfirmFieldState with field valid when email is valid',
    build: () => ConfirmFieldCubit(fieldValidator: validateEmail),
    act: (cubit) => cubit.onFieldChanged('good@email.com'),
    expect: () => const [
      ConfirmFieldState(
        fieldErrorMsg: null,
        confirmFieldErrorMsg: null,
        field: 'good@email.com',
        confirmField: '',
        isFieldValid: true,
        isConfirmFieldValid: false,
      ),
    ],
  );

  blocTest<ConfirmFieldCubit, ConfirmFieldState>(
    'emits $ConfirmFieldState with fieldErrorMsg non null when email is invalid',
    build: () => ConfirmFieldCubit(fieldValidator: validateEmail),
    act: (cubit) => cubit.onFieldChanged('g'),
    expect: () => const [
      ConfirmFieldState(
        fieldErrorMsg: 'Invalid email adress',
        confirmFieldErrorMsg: null,
        field: 'g',
        confirmField: '',
        isFieldValid: false,
        isConfirmFieldValid: false,
      ),
    ],
  );

  blocTest<ConfirmFieldCubit, ConfirmFieldState>(
    '''
    GIVEN last ConfirmFieldState had email and confirmEmail valid and equal
    WHEN removing the last character of email
    THEN emits ConfirmFieldState with confirmFieldErrorMsg non null
    ''',
    build: () => ConfirmFieldCubit(fieldValidator: validateEmail),
    seed: () => ConfirmFieldState(
      confirmFieldErrorMsg: null,
      fieldErrorMsg: null,
      field: 'good@email.com',
      confirmField: 'good@email.com',
      isConfirmFieldValid: true,
      isFieldValid: true,
    ),
    act: (cubit) => cubit.onFieldChanged('good@email.co'),
    expect: () => const [
      ConfirmFieldState(
        fieldErrorMsg: null,
        confirmFieldErrorMsg: ConfirmFieldCubit.defaultNonCorrespondingErrorMsg,
        field: 'good@email.co',
        confirmField: 'good@email.com',
        isFieldValid: true,
        isConfirmFieldValid: false,
      ),
    ],
  );

  // - invalidate confirm field when email is invalid
  // - invalidate confirm field when field has be emptied
  // - invalidate confirm field when email is valid but different from original field
  // - validate confirm field when email is valid and equal to original field
}
