// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'surveys_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SurveysState {
  Value<List<Survey>> get surveysState;
  int get currentPage;
  bool get hasMore;

  /// Create a copy of SurveysState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SurveysStateCopyWith<SurveysState> get copyWith =>
      _$SurveysStateCopyWithImpl<SurveysState>(
          this as SurveysState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SurveysState &&
            (identical(other.surveysState, surveysState) ||
                other.surveysState == surveysState) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, surveysState, currentPage, hasMore);

  @override
  String toString() {
    return 'SurveysState(surveysState: $surveysState, currentPage: $currentPage, hasMore: $hasMore)';
  }
}

/// @nodoc
abstract mixin class $SurveysStateCopyWith<$Res> {
  factory $SurveysStateCopyWith(
          SurveysState value, $Res Function(SurveysState) _then) =
      _$SurveysStateCopyWithImpl;
  @useResult
  $Res call({Value<List<Survey>> surveysState, int currentPage, bool hasMore});
}

/// @nodoc
class _$SurveysStateCopyWithImpl<$Res> implements $SurveysStateCopyWith<$Res> {
  _$SurveysStateCopyWithImpl(this._self, this._then);

  final SurveysState _self;
  final $Res Function(SurveysState) _then;

  /// Create a copy of SurveysState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? surveysState = null,
    Object? currentPage = null,
    Object? hasMore = null,
  }) {
    return _then(_self.copyWith(
      surveysState: null == surveysState
          ? _self.surveysState
          : surveysState // ignore: cast_nullable_to_non_nullable
              as Value<List<Survey>>,
      currentPage: null == currentPage
          ? _self.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      hasMore: null == hasMore
          ? _self.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _SurveysState implements SurveysState {
  const _SurveysState(
      {this.surveysState = const Value.initial(),
      this.currentPage = 1,
      this.hasMore = true});

  @override
  @JsonKey()
  final Value<List<Survey>> surveysState;
  @override
  @JsonKey()
  final int currentPage;
  @override
  @JsonKey()
  final bool hasMore;

  /// Create a copy of SurveysState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SurveysStateCopyWith<_SurveysState> get copyWith =>
      __$SurveysStateCopyWithImpl<_SurveysState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SurveysState &&
            (identical(other.surveysState, surveysState) ||
                other.surveysState == surveysState) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, surveysState, currentPage, hasMore);

  @override
  String toString() {
    return 'SurveysState(surveysState: $surveysState, currentPage: $currentPage, hasMore: $hasMore)';
  }
}

/// @nodoc
abstract mixin class _$SurveysStateCopyWith<$Res>
    implements $SurveysStateCopyWith<$Res> {
  factory _$SurveysStateCopyWith(
          _SurveysState value, $Res Function(_SurveysState) _then) =
      __$SurveysStateCopyWithImpl;
  @override
  @useResult
  $Res call({Value<List<Survey>> surveysState, int currentPage, bool hasMore});
}

/// @nodoc
class __$SurveysStateCopyWithImpl<$Res>
    implements _$SurveysStateCopyWith<$Res> {
  __$SurveysStateCopyWithImpl(this._self, this._then);

  final _SurveysState _self;
  final $Res Function(_SurveysState) _then;

  /// Create a copy of SurveysState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? surveysState = null,
    Object? currentPage = null,
    Object? hasMore = null,
  }) {
    return _then(_SurveysState(
      surveysState: null == surveysState
          ? _self.surveysState
          : surveysState // ignore: cast_nullable_to_non_nullable
              as Value<List<Survey>>,
      currentPage: null == currentPage
          ? _self.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      hasMore: null == hasMore
          ? _self.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
