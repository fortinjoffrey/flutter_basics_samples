// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_answers_cubit_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreateAnswersCubitState {
  List<String> get answers => throw _privateConstructorUsedError;
  AnswerType? get answerType => throw _privateConstructorUsedError;

  /// Create a copy of CreateAnswersCubitState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateAnswersCubitStateCopyWith<CreateAnswersCubitState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateAnswersCubitStateCopyWith<$Res> {
  factory $CreateAnswersCubitStateCopyWith(CreateAnswersCubitState value,
          $Res Function(CreateAnswersCubitState) then) =
      _$CreateAnswersCubitStateCopyWithImpl<$Res, CreateAnswersCubitState>;
  @useResult
  $Res call({List<String> answers, AnswerType? answerType});
}

/// @nodoc
class _$CreateAnswersCubitStateCopyWithImpl<$Res,
        $Val extends CreateAnswersCubitState>
    implements $CreateAnswersCubitStateCopyWith<$Res> {
  _$CreateAnswersCubitStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateAnswersCubitState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? answers = null,
    Object? answerType = freezed,
  }) {
    return _then(_value.copyWith(
      answers: null == answers
          ? _value.answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      answerType: freezed == answerType
          ? _value.answerType
          : answerType // ignore: cast_nullable_to_non_nullable
              as AnswerType?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateAnswersCubitStateImplCopyWith<$Res>
    implements $CreateAnswersCubitStateCopyWith<$Res> {
  factory _$$CreateAnswersCubitStateImplCopyWith(
          _$CreateAnswersCubitStateImpl value,
          $Res Function(_$CreateAnswersCubitStateImpl) then) =
      __$$CreateAnswersCubitStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> answers, AnswerType? answerType});
}

/// @nodoc
class __$$CreateAnswersCubitStateImplCopyWithImpl<$Res>
    extends _$CreateAnswersCubitStateCopyWithImpl<$Res,
        _$CreateAnswersCubitStateImpl>
    implements _$$CreateAnswersCubitStateImplCopyWith<$Res> {
  __$$CreateAnswersCubitStateImplCopyWithImpl(
      _$CreateAnswersCubitStateImpl _value,
      $Res Function(_$CreateAnswersCubitStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateAnswersCubitState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? answers = null,
    Object? answerType = freezed,
  }) {
    return _then(_$CreateAnswersCubitStateImpl(
      answers: null == answers
          ? _value._answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      answerType: freezed == answerType
          ? _value.answerType
          : answerType // ignore: cast_nullable_to_non_nullable
              as AnswerType?,
    ));
  }
}

/// @nodoc

class _$CreateAnswersCubitStateImpl implements _CreateAnswersCubitState {
  const _$CreateAnswersCubitStateImpl(
      {final List<String> answers = const [], this.answerType})
      : _answers = answers;

  final List<String> _answers;
  @override
  @JsonKey()
  List<String> get answers {
    if (_answers is EqualUnmodifiableListView) return _answers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_answers);
  }

  @override
  final AnswerType? answerType;

  @override
  String toString() {
    return 'CreateAnswersCubitState(answers: $answers, answerType: $answerType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateAnswersCubitStateImpl &&
            const DeepCollectionEquality().equals(other._answers, _answers) &&
            (identical(other.answerType, answerType) ||
                other.answerType == answerType));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_answers), answerType);

  /// Create a copy of CreateAnswersCubitState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateAnswersCubitStateImplCopyWith<_$CreateAnswersCubitStateImpl>
      get copyWith => __$$CreateAnswersCubitStateImplCopyWithImpl<
          _$CreateAnswersCubitStateImpl>(this, _$identity);
}

abstract class _CreateAnswersCubitState implements CreateAnswersCubitState {
  const factory _CreateAnswersCubitState(
      {final List<String> answers,
      final AnswerType? answerType}) = _$CreateAnswersCubitStateImpl;

  @override
  List<String> get answers;
  @override
  AnswerType? get answerType;

  /// Create a copy of CreateAnswersCubitState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateAnswersCubitStateImplCopyWith<_$CreateAnswersCubitStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
