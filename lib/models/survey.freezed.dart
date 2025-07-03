// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'survey.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Survey {
  String get id;
  String get question;
  bool get displayResults;

  /// Create a copy of Survey
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SurveyCopyWith<Survey> get copyWith =>
      _$SurveyCopyWithImpl<Survey>(this as Survey, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Survey &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.displayResults, displayResults) ||
                other.displayResults == displayResults));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, question, displayResults);

  @override
  String toString() {
    return 'Survey(id: $id, question: $question, displayResults: $displayResults)';
  }
}

/// @nodoc
abstract mixin class $SurveyCopyWith<$Res> {
  factory $SurveyCopyWith(Survey value, $Res Function(Survey) _then) =
      _$SurveyCopyWithImpl;
  @useResult
  $Res call({String id, String question, bool displayResults});
}

/// @nodoc
class _$SurveyCopyWithImpl<$Res> implements $SurveyCopyWith<$Res> {
  _$SurveyCopyWithImpl(this._self, this._then);

  final Survey _self;
  final $Res Function(Survey) _then;

  /// Create a copy of Survey
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? question = null,
    Object? displayResults = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      question: null == question
          ? _self.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      displayResults: null == displayResults
          ? _self.displayResults
          : displayResults // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _Survey implements Survey {
  const _Survey(
      {required this.id, required this.question, required this.displayResults});

  @override
  final String id;
  @override
  final String question;
  @override
  final bool displayResults;

  /// Create a copy of Survey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SurveyCopyWith<_Survey> get copyWith =>
      __$SurveyCopyWithImpl<_Survey>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Survey &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.displayResults, displayResults) ||
                other.displayResults == displayResults));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, question, displayResults);

  @override
  String toString() {
    return 'Survey(id: $id, question: $question, displayResults: $displayResults)';
  }
}

/// @nodoc
abstract mixin class _$SurveyCopyWith<$Res> implements $SurveyCopyWith<$Res> {
  factory _$SurveyCopyWith(_Survey value, $Res Function(_Survey) _then) =
      __$SurveyCopyWithImpl;
  @override
  @useResult
  $Res call({String id, String question, bool displayResults});
}

/// @nodoc
class __$SurveyCopyWithImpl<$Res> implements _$SurveyCopyWith<$Res> {
  __$SurveyCopyWithImpl(this._self, this._then);

  final _Survey _self;
  final $Res Function(_Survey) _then;

  /// Create a copy of Survey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? question = null,
    Object? displayResults = null,
  }) {
    return _then(_Survey(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      question: null == question
          ? _self.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      displayResults: null == displayResults
          ? _self.displayResults
          : displayResults // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
