part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class GetWeatherEvent implements WeatherEvent {
  GetWeatherEvent(this.cityname);

  final String cityname;
}
