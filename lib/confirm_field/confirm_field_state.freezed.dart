// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'confirm_field_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ConfirmFieldState {
  String get field => throw _privateConstructorUsedError;
  String get confirmField => throw _privateConstructorUsedError;
  String? get fieldErrorMsg => throw _privateConstructorUsedError;
  String? get confirmFieldErrorMsg => throw _privateConstructorUsedError;
  bool get isFieldValid => throw _privateConstructorUsedError;
  bool get isConfirmFieldValid => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ConfirmFieldStateCopyWith<ConfirmFieldState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfirmFieldStateCopyWith<$Res> {
  factory $ConfirmFieldStateCopyWith(
          ConfirmFieldState value, $Res Function(ConfirmFieldState) then) =
      _$ConfirmFieldStateCopyWithImpl<$Res, ConfirmFieldState>;
  @useResult
  $Res call(
      {String field,
      String confirmField,
      String? fieldErrorMsg,
      String? confirmFieldErrorMsg,
      bool isFieldValid,
      bool isConfirmFieldValid});
}

/// @nodoc
class _$ConfirmFieldStateCopyWithImpl<$Res, $Val extends ConfirmFieldState>
    implements $ConfirmFieldStateCopyWith<$Res> {
  _$ConfirmFieldStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field = null,
    Object? confirmField = null,
    Object? fieldErrorMsg = freezed,
    Object? confirmFieldErrorMsg = freezed,
    Object? isFieldValid = null,
    Object? isConfirmFieldValid = null,
  }) {
    return _then(_value.copyWith(
      field: null == field
          ? _value.field
          : field // ignore: cast_nullable_to_non_nullable
              as String,
      confirmField: null == confirmField
          ? _value.confirmField
          : confirmField // ignore: cast_nullable_to_non_nullable
              as String,
      fieldErrorMsg: freezed == fieldErrorMsg
          ? _value.fieldErrorMsg
          : fieldErrorMsg // ignore: cast_nullable_to_non_nullable
              as String?,
      confirmFieldErrorMsg: freezed == confirmFieldErrorMsg
          ? _value.confirmFieldErrorMsg
          : confirmFieldErrorMsg // ignore: cast_nullable_to_non_nullable
              as String?,
      isFieldValid: null == isFieldValid
          ? _value.isFieldValid
          : isFieldValid // ignore: cast_nullable_to_non_nullable
              as bool,
      isConfirmFieldValid: null == isConfirmFieldValid
          ? _value.isConfirmFieldValid
          : isConfirmFieldValid // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ConfirmFieldStateCopyWith<$Res>
    implements $ConfirmFieldStateCopyWith<$Res> {
  factory _$$_ConfirmFieldStateCopyWith(_$_ConfirmFieldState value,
          $Res Function(_$_ConfirmFieldState) then) =
      __$$_ConfirmFieldStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String field,
      String confirmField,
      String? fieldErrorMsg,
      String? confirmFieldErrorMsg,
      bool isFieldValid,
      bool isConfirmFieldValid});
}

/// @nodoc
class __$$_ConfirmFieldStateCopyWithImpl<$Res>
    extends _$ConfirmFieldStateCopyWithImpl<$Res, _$_ConfirmFieldState>
    implements _$$_ConfirmFieldStateCopyWith<$Res> {
  __$$_ConfirmFieldStateCopyWithImpl(
      _$_ConfirmFieldState _value, $Res Function(_$_ConfirmFieldState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field = null,
    Object? confirmField = null,
    Object? fieldErrorMsg = freezed,
    Object? confirmFieldErrorMsg = freezed,
    Object? isFieldValid = null,
    Object? isConfirmFieldValid = null,
  }) {
    return _then(_$_ConfirmFieldState(
      field: null == field
          ? _value.field
          : field // ignore: cast_nullable_to_non_nullable
              as String,
      confirmField: null == confirmField
          ? _value.confirmField
          : confirmField // ignore: cast_nullable_to_non_nullable
              as String,
      fieldErrorMsg: freezed == fieldErrorMsg
          ? _value.fieldErrorMsg
          : fieldErrorMsg // ignore: cast_nullable_to_non_nullable
              as String?,
      confirmFieldErrorMsg: freezed == confirmFieldErrorMsg
          ? _value.confirmFieldErrorMsg
          : confirmFieldErrorMsg // ignore: cast_nullable_to_non_nullable
              as String?,
      isFieldValid: null == isFieldValid
          ? _value.isFieldValid
          : isFieldValid // ignore: cast_nullable_to_non_nullable
              as bool,
      isConfirmFieldValid: null == isConfirmFieldValid
          ? _value.isConfirmFieldValid
          : isConfirmFieldValid // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_ConfirmFieldState implements _ConfirmFieldState {
  const _$_ConfirmFieldState(
      {this.field = '',
      this.confirmField = '',
      required this.fieldErrorMsg,
      required this.confirmFieldErrorMsg,
      this.isFieldValid = false,
      this.isConfirmFieldValid = false});

  @override
  @JsonKey()
  final String field;
  @override
  @JsonKey()
  final String confirmField;
  @override
  final String? fieldErrorMsg;
  @override
  final String? confirmFieldErrorMsg;
  @override
  @JsonKey()
  final bool isFieldValid;
  @override
  @JsonKey()
  final bool isConfirmFieldValid;

  @override
  String toString() {
    return 'ConfirmFieldState(field: $field, confirmField: $confirmField, fieldErrorMsg: $fieldErrorMsg, confirmFieldErrorMsg: $confirmFieldErrorMsg, isFieldValid: $isFieldValid, isConfirmFieldValid: $isConfirmFieldValid)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ConfirmFieldState &&
            (identical(other.field, field) || other.field == field) &&
            (identical(other.confirmField, confirmField) ||
                other.confirmField == confirmField) &&
            (identical(other.fieldErrorMsg, fieldErrorMsg) ||
                other.fieldErrorMsg == fieldErrorMsg) &&
            (identical(other.confirmFieldErrorMsg, confirmFieldErrorMsg) ||
                other.confirmFieldErrorMsg == confirmFieldErrorMsg) &&
            (identical(other.isFieldValid, isFieldValid) ||
                other.isFieldValid == isFieldValid) &&
            (identical(other.isConfirmFieldValid, isConfirmFieldValid) ||
                other.isConfirmFieldValid == isConfirmFieldValid));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field, confirmField,
      fieldErrorMsg, confirmFieldErrorMsg, isFieldValid, isConfirmFieldValid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ConfirmFieldStateCopyWith<_$_ConfirmFieldState> get copyWith =>
      __$$_ConfirmFieldStateCopyWithImpl<_$_ConfirmFieldState>(
          this, _$identity);
}

abstract class _ConfirmFieldState implements ConfirmFieldState {
  const factory _ConfirmFieldState(
      {final String field,
      final String confirmField,
      required final String? fieldErrorMsg,
      required final String? confirmFieldErrorMsg,
      final bool isFieldValid,
      final bool isConfirmFieldValid}) = _$_ConfirmFieldState;

  @override
  String get field;
  @override
  String get confirmField;
  @override
  String? get fieldErrorMsg;
  @override
  String? get confirmFieldErrorMsg;
  @override
  bool get isFieldValid;
  @override
  bool get isConfirmFieldValid;
  @override
  @JsonKey(ignore: true)
  _$$_ConfirmFieldStateCopyWith<_$_ConfirmFieldState> get copyWith =>
      throw _privateConstructorUsedError;
}
