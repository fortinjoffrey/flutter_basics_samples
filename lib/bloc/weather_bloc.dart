import 'dart:async';

import 'package:basics_samples/data/model/weather.dart';
import 'package:basics_samples/data/weather_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _weatherRepository;

  WeatherBloc(this._weatherRepository) : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is GetWeather) {
      try {
        yield const WeatherLoading();

        final weather = await _weatherRepository.fetchWeather(event.cityName);
        yield WeatherLoaded(weather);
      } catch (e) {
        yield (WeatherError('Couldn\'t fetch weather.'));
      }
    }
  }
}
