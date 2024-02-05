// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_map_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FeedMapState {
  MapMode get mode => throw _privateConstructorUsedError;
  PermissionStatus? get permissionStatus => throw _privateConstructorUsedError;
  LatLng? get userLocation => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FeedMapStateCopyWith<FeedMapState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedMapStateCopyWith<$Res> {
  factory $FeedMapStateCopyWith(
          FeedMapState value, $Res Function(FeedMapState) then) =
      _$FeedMapStateCopyWithImpl<$Res, FeedMapState>;
  @useResult
  $Res call(
      {MapMode mode, PermissionStatus? permissionStatus, LatLng? userLocation});
}

/// @nodoc
class _$FeedMapStateCopyWithImpl<$Res, $Val extends FeedMapState>
    implements $FeedMapStateCopyWith<$Res> {
  _$FeedMapStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
    Object? permissionStatus = freezed,
    Object? userLocation = freezed,
  }) {
    return _then(_value.copyWith(
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as MapMode,
      permissionStatus: freezed == permissionStatus
          ? _value.permissionStatus
          : permissionStatus // ignore: cast_nullable_to_non_nullable
              as PermissionStatus?,
      userLocation: freezed == userLocation
          ? _value.userLocation
          : userLocation // ignore: cast_nullable_to_non_nullable
              as LatLng?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeedMapStateImplCopyWith<$Res>
    implements $FeedMapStateCopyWith<$Res> {
  factory _$$FeedMapStateImplCopyWith(
          _$FeedMapStateImpl value, $Res Function(_$FeedMapStateImpl) then) =
      __$$FeedMapStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {MapMode mode, PermissionStatus? permissionStatus, LatLng? userLocation});
}

/// @nodoc
class __$$FeedMapStateImplCopyWithImpl<$Res>
    extends _$FeedMapStateCopyWithImpl<$Res, _$FeedMapStateImpl>
    implements _$$FeedMapStateImplCopyWith<$Res> {
  __$$FeedMapStateImplCopyWithImpl(
      _$FeedMapStateImpl _value, $Res Function(_$FeedMapStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
    Object? permissionStatus = freezed,
    Object? userLocation = freezed,
  }) {
    return _then(_$FeedMapStateImpl(
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as MapMode,
      permissionStatus: freezed == permissionStatus
          ? _value.permissionStatus
          : permissionStatus // ignore: cast_nullable_to_non_nullable
              as PermissionStatus?,
      userLocation: freezed == userLocation
          ? _value.userLocation
          : userLocation // ignore: cast_nullable_to_non_nullable
              as LatLng?,
    ));
  }
}

/// @nodoc

class _$FeedMapStateImpl implements _FeedMapState {
  const _$FeedMapStateImpl(
      {this.mode = const FreeMoveMapMode(),
      this.permissionStatus,
      this.userLocation});

  @override
  @JsonKey()
  final MapMode mode;
  @override
  final PermissionStatus? permissionStatus;
  @override
  final LatLng? userLocation;

  @override
  String toString() {
    return 'FeedMapState(mode: $mode, permissionStatus: $permissionStatus, userLocation: $userLocation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedMapStateImpl &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.permissionStatus, permissionStatus) ||
                other.permissionStatus == permissionStatus) &&
            (identical(other.userLocation, userLocation) ||
                other.userLocation == userLocation));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, mode, permissionStatus, userLocation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedMapStateImplCopyWith<_$FeedMapStateImpl> get copyWith =>
      __$$FeedMapStateImplCopyWithImpl<_$FeedMapStateImpl>(this, _$identity);
}

abstract class _FeedMapState implements FeedMapState {
  const factory _FeedMapState(
      {final MapMode mode,
      final PermissionStatus? permissionStatus,
      final LatLng? userLocation}) = _$FeedMapStateImpl;

  @override
  MapMode get mode;
  @override
  PermissionStatus? get permissionStatus;
  @override
  LatLng? get userLocation;
  @override
  @JsonKey(ignore: true)
  _$$FeedMapStateImplCopyWith<_$FeedMapStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
