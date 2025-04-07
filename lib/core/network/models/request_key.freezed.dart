// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request_key.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RequestKey {
  String get name;
  String? get id;

  /// Create a copy of RequestKey
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RequestKeyCopyWith<RequestKey> get copyWith =>
      _$RequestKeyCopyWithImpl<RequestKey>(this as RequestKey, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RequestKey &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, id);

  @override
  String toString() {
    return 'RequestKey(name: $name, id: $id)';
  }
}

/// @nodoc
abstract mixin class $RequestKeyCopyWith<$Res> {
  factory $RequestKeyCopyWith(
          RequestKey value, $Res Function(RequestKey) _then) =
      _$RequestKeyCopyWithImpl;
  @useResult
  $Res call({String name, String? id});
}

/// @nodoc
class _$RequestKeyCopyWithImpl<$Res> implements $RequestKeyCopyWith<$Res> {
  _$RequestKeyCopyWithImpl(this._self, this._then);

  final RequestKey _self;
  final $Res Function(RequestKey) _then;

  /// Create a copy of RequestKey
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = freezed,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _RequestKey implements RequestKey {
  const _RequestKey({required this.name, this.id});

  @override
  final String name;
  @override
  final String? id;

  /// Create a copy of RequestKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RequestKeyCopyWith<_RequestKey> get copyWith =>
      __$RequestKeyCopyWithImpl<_RequestKey>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RequestKey &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, id);

  @override
  String toString() {
    return 'RequestKey(name: $name, id: $id)';
  }
}

/// @nodoc
abstract mixin class _$RequestKeyCopyWith<$Res>
    implements $RequestKeyCopyWith<$Res> {
  factory _$RequestKeyCopyWith(
          _RequestKey value, $Res Function(_RequestKey) _then) =
      __$RequestKeyCopyWithImpl;
  @override
  @useResult
  $Res call({String name, String? id});
}

/// @nodoc
class __$RequestKeyCopyWithImpl<$Res> implements _$RequestKeyCopyWith<$Res> {
  __$RequestKeyCopyWithImpl(this._self, this._then);

  final _RequestKey _self;
  final $Res Function(_RequestKey) _then;

  /// Create a copy of RequestKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? id = freezed,
  }) {
    return _then(_RequestKey(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
