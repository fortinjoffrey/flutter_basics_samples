import 'dart:math';

import 'package:basics_samples/models/weather.dart';

abstract class WeatherRepository {
  /// Throws [NetworkException].
  Future<Weather> fetchWeather(String cityName);
}

class FakeWeatherRepository implements WeatherRepository {
  @override
  Future<Weather> fetchWeather(String cityName) async {

    // simulate network delay
    await Future<void>.delayed(const Duration(seconds: 1));

    final Random random = Random();

    // simulate exception
    if (cityName.isEmpty || cityName.contains('error')) throw NetworkException();

    // Return "fetched" weather
    return Weather(
      cityName: cityName,
      // Random temperature between 20 and 35.99
      temperatureCelsius: 20 + random.nextInt(15) + random.nextDouble(),
    );
  }
}

class NetworkException implements Exception {}
