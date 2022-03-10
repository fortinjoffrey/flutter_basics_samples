// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'child.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Child _$ChildFromJson(Map<String, dynamic> json) {
  return _Child.fromJson(json);
}

/// @nodoc
class _$ChildTearOff {
  const _$ChildTearOff();

  _Child call({required String name}) {
    return _Child(
      name: name,
    );
  }

  Child fromJson(Map<String, Object?> json) {
    return Child.fromJson(json);
  }
}

/// @nodoc
const $Child = _$ChildTearOff();

/// @nodoc
mixin _$Child {
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChildCopyWith<Child> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChildCopyWith<$Res> {
  factory $ChildCopyWith(Child value, $Res Function(Child) then) =
      _$ChildCopyWithImpl<$Res>;
  $Res call({String name});
}

/// @nodoc
class _$ChildCopyWithImpl<$Res> implements $ChildCopyWith<$Res> {
  _$ChildCopyWithImpl(this._value, this._then);

  final Child _value;
  // ignore: unused_field
  final $Res Function(Child) _then;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$ChildCopyWith<$Res> implements $ChildCopyWith<$Res> {
  factory _$ChildCopyWith(_Child value, $Res Function(_Child) then) =
      __$ChildCopyWithImpl<$Res>;
  @override
  $Res call({String name});
}

/// @nodoc
class __$ChildCopyWithImpl<$Res> extends _$ChildCopyWithImpl<$Res>
    implements _$ChildCopyWith<$Res> {
  __$ChildCopyWithImpl(_Child _value, $Res Function(_Child) _then)
      : super(_value, (v) => _then(v as _Child));

  @override
  _Child get _value => super._value as _Child;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_Child(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_Child implements _Child {
  const _$_Child({required this.name});

  factory _$_Child.fromJson(Map<String, dynamic> json) =>
      _$$_ChildFromJson(json);

  @override
  final String name;

  @override
  String toString() {
    return 'Child(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Child &&
            const DeepCollectionEquality().equals(other.name, name));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(name));

  @JsonKey(ignore: true)
  @override
  _$ChildCopyWith<_Child> get copyWith =>
      __$ChildCopyWithImpl<_Child>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChildToJson(this);
  }
}

abstract class _Child implements Child {
  const factory _Child({required String name}) = _$_Child;

  factory _Child.fromJson(Map<String, dynamic> json) = _$_Child.fromJson;

  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$ChildCopyWith<_Child> get copyWith => throw _privateConstructorUsedError;
}
