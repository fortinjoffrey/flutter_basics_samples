// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_bloc_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FeedBlocState {
  FeedDisplayMode get displayMode => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FeedBlocStateCopyWith<FeedBlocState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedBlocStateCopyWith<$Res> {
  factory $FeedBlocStateCopyWith(
          FeedBlocState value, $Res Function(FeedBlocState) then) =
      _$FeedBlocStateCopyWithImpl<$Res, FeedBlocState>;
  @useResult
  $Res call({FeedDisplayMode displayMode});
}

/// @nodoc
class _$FeedBlocStateCopyWithImpl<$Res, $Val extends FeedBlocState>
    implements $FeedBlocStateCopyWith<$Res> {
  _$FeedBlocStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayMode = null,
  }) {
    return _then(_value.copyWith(
      displayMode: null == displayMode
          ? _value.displayMode
          : displayMode // ignore: cast_nullable_to_non_nullable
              as FeedDisplayMode,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeedBlocStateImplCopyWith<$Res>
    implements $FeedBlocStateCopyWith<$Res> {
  factory _$$FeedBlocStateImplCopyWith(
          _$FeedBlocStateImpl value, $Res Function(_$FeedBlocStateImpl) then) =
      __$$FeedBlocStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({FeedDisplayMode displayMode});
}

/// @nodoc
class __$$FeedBlocStateImplCopyWithImpl<$Res>
    extends _$FeedBlocStateCopyWithImpl<$Res, _$FeedBlocStateImpl>
    implements _$$FeedBlocStateImplCopyWith<$Res> {
  __$$FeedBlocStateImplCopyWithImpl(
      _$FeedBlocStateImpl _value, $Res Function(_$FeedBlocStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayMode = null,
  }) {
    return _then(_$FeedBlocStateImpl(
      displayMode: null == displayMode
          ? _value.displayMode
          : displayMode // ignore: cast_nullable_to_non_nullable
              as FeedDisplayMode,
    ));
  }
}

/// @nodoc

class _$FeedBlocStateImpl implements _FeedBlocState {
  const _$FeedBlocStateImpl({this.displayMode = const FeedMapDisplayMode()});

  @override
  @JsonKey()
  final FeedDisplayMode displayMode;

  @override
  String toString() {
    return 'FeedBlocState(displayMode: $displayMode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedBlocStateImpl &&
            (identical(other.displayMode, displayMode) ||
                other.displayMode == displayMode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, displayMode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedBlocStateImplCopyWith<_$FeedBlocStateImpl> get copyWith =>
      __$$FeedBlocStateImplCopyWithImpl<_$FeedBlocStateImpl>(this, _$identity);
}

abstract class _FeedBlocState implements FeedBlocState {
  const factory _FeedBlocState({final FeedDisplayMode displayMode}) =
      _$FeedBlocStateImpl;

  @override
  FeedDisplayMode get displayMode;
  @override
  @JsonKey(ignore: true)
  _$$FeedBlocStateImplCopyWith<_$FeedBlocStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
