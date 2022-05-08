
import 'package:basics_samples/models/weather.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class WeatherState {
  const WeatherState();
}

class WeatherInitial extends WeatherState {
  const WeatherInitial();
}

class WeatherLoading extends WeatherState {
  const WeatherLoading();
}

class WeatherError extends WeatherState {
  final String message;
  const WeatherError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WeatherError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class WeatherLoaded extends WeatherState {
  final Weather weather;
  const WeatherLoaded(this.weather);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WeatherLoaded && other.weather == weather;
  }

  @override
  int get hashCode => weather.hashCode;
}