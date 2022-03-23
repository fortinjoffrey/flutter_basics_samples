// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'weather_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$WeatherEventTearOff {
  const _$WeatherEventTearOff();

  GetWeather getWeather(String cityName) {
    return GetWeather(
      cityName,
    );
  }
}

/// @nodoc
const $WeatherEvent = _$WeatherEventTearOff();

/// @nodoc
mixin _$WeatherEvent {
  String get cityName => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String cityName) getWeather,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String cityName)? getWeather,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String cityName)? getWeather,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetWeather value) getWeather,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(GetWeather value)? getWeather,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetWeather value)? getWeather,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WeatherEventCopyWith<WeatherEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherEventCopyWith<$Res> {
  factory $WeatherEventCopyWith(
          WeatherEvent value, $Res Function(WeatherEvent) then) =
      _$WeatherEventCopyWithImpl<$Res>;
  $Res call({String cityName});
}

/// @nodoc
class _$WeatherEventCopyWithImpl<$Res> implements $WeatherEventCopyWith<$Res> {
  _$WeatherEventCopyWithImpl(this._value, this._then);

  final WeatherEvent _value;
  // ignore: unused_field
  final $Res Function(WeatherEvent) _then;

  @override
  $Res call({
    Object? cityName = freezed,
  }) {
    return _then(_value.copyWith(
      cityName: cityName == freezed
          ? _value.cityName
          : cityName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class $GetWeatherCopyWith<$Res>
    implements $WeatherEventCopyWith<$Res> {
  factory $GetWeatherCopyWith(
          GetWeather value, $Res Function(GetWeather) then) =
      _$GetWeatherCopyWithImpl<$Res>;
  @override
  $Res call({String cityName});
}

/// @nodoc
class _$GetWeatherCopyWithImpl<$Res> extends _$WeatherEventCopyWithImpl<$Res>
    implements $GetWeatherCopyWith<$Res> {
  _$GetWeatherCopyWithImpl(GetWeather _value, $Res Function(GetWeather) _then)
      : super(_value, (v) => _then(v as GetWeather));

  @override
  GetWeather get _value => super._value as GetWeather;

  @override
  $Res call({
    Object? cityName = freezed,
  }) {
    return _then(GetWeather(
      cityName == freezed
          ? _value.cityName
          : cityName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GetWeather implements GetWeather {
  const _$GetWeather(this.cityName);

  @override
  final String cityName;

  @override
  String toString() {
    return 'WeatherEvent.getWeather(cityName: $cityName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GetWeather &&
            const DeepCollectionEquality().equals(other.cityName, cityName));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(cityName));

  @JsonKey(ignore: true)
  @override
  $GetWeatherCopyWith<GetWeather> get copyWith =>
      _$GetWeatherCopyWithImpl<GetWeather>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String cityName) getWeather,
  }) {
    return getWeather(cityName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String cityName)? getWeather,
  }) {
    return getWeather?.call(cityName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String cityName)? getWeather,
    required TResult orElse(),
  }) {
    if (getWeather != null) {
      return getWeather(cityName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetWeather value) getWeather,
  }) {
    return getWeather(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(GetWeather value)? getWeather,
  }) {
    return getWeather?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetWeather value)? getWeather,
    required TResult orElse(),
  }) {
    if (getWeather != null) {
      return getWeather(this);
    }
    return orElse();
  }
}

abstract class GetWeather implements WeatherEvent {
  const factory GetWeather(String cityName) = _$GetWeather;

  @override
  String get cityName;
  @override
  @JsonKey(ignore: true)
  $GetWeatherCopyWith<GetWeather> get copyWith =>
      throw _privateConstructorUsedError;
}
