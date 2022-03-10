// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'father.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Father _$FatherFromJson(Map<String, dynamic> json) {
  return _Father.fromJson(json);
}

/// @nodoc
class _$FatherTearOff {
  const _$FatherTearOff();

  _Father call({required String name, required Child child}) {
    return _Father(
      name: name,
      child: child,
    );
  }

  Father fromJson(Map<String, Object?> json) {
    return Father.fromJson(json);
  }
}

/// @nodoc
const $Father = _$FatherTearOff();

/// @nodoc
mixin _$Father {
  String get name => throw _privateConstructorUsedError;
  Child get child => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FatherCopyWith<Father> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FatherCopyWith<$Res> {
  factory $FatherCopyWith(Father value, $Res Function(Father) then) =
      _$FatherCopyWithImpl<$Res>;
  $Res call({String name, Child child});

  $ChildCopyWith<$Res> get child;
}

/// @nodoc
class _$FatherCopyWithImpl<$Res> implements $FatherCopyWith<$Res> {
  _$FatherCopyWithImpl(this._value, this._then);

  final Father _value;
  // ignore: unused_field
  final $Res Function(Father) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? child = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      child: child == freezed
          ? _value.child
          : child // ignore: cast_nullable_to_non_nullable
              as Child,
    ));
  }

  @override
  $ChildCopyWith<$Res> get child {
    return $ChildCopyWith<$Res>(_value.child, (value) {
      return _then(_value.copyWith(child: value));
    });
  }
}

/// @nodoc
abstract class _$FatherCopyWith<$Res> implements $FatherCopyWith<$Res> {
  factory _$FatherCopyWith(_Father value, $Res Function(_Father) then) =
      __$FatherCopyWithImpl<$Res>;
  @override
  $Res call({String name, Child child});

  @override
  $ChildCopyWith<$Res> get child;
}

/// @nodoc
class __$FatherCopyWithImpl<$Res> extends _$FatherCopyWithImpl<$Res>
    implements _$FatherCopyWith<$Res> {
  __$FatherCopyWithImpl(_Father _value, $Res Function(_Father) _then)
      : super(_value, (v) => _then(v as _Father));

  @override
  _Father get _value => super._value as _Father;

  @override
  $Res call({
    Object? name = freezed,
    Object? child = freezed,
  }) {
    return _then(_Father(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      child: child == freezed
          ? _value.child
          : child // ignore: cast_nullable_to_non_nullable
              as Child,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_Father implements _Father {
  const _$_Father({required this.name, required this.child});

  factory _$_Father.fromJson(Map<String, dynamic> json) =>
      _$$_FatherFromJson(json);

  @override
  final String name;
  @override
  final Child child;

  @override
  String toString() {
    return 'Father(name: $name, child: $child)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Father &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.child, child));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(child));

  @JsonKey(ignore: true)
  @override
  _$FatherCopyWith<_Father> get copyWith =>
      __$FatherCopyWithImpl<_Father>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FatherToJson(this);
  }
}

abstract class _Father implements Father {
  const factory _Father({required String name, required Child child}) =
      _$_Father;

  factory _Father.fromJson(Map<String, dynamic> json) = _$_Father.fromJson;

  @override
  String get name;
  @override
  Child get child;
  @override
  @JsonKey(ignore: true)
  _$FatherCopyWith<_Father> get copyWith => throw _privateConstructorUsedError;
}
