import 'dart:async';
import 'package:basics_samples/data/model/data_state.dart';
import 'package:basics_samples/data/model/weather.dart';
import 'package:basics_samples/data/weather_repository.dart';
import 'package:bloc/bloc.dart';
import 'weather_event.dart';

class WeatherBloc extends Bloc<WeatherEvent, DataState<Weather>> {
  final WeatherRepository _weatherRepository;

  WeatherBloc(this._weatherRepository) : super(DataState.initial());

  @override
  Stream<DataState<Weather>> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is GetWeather) {
      try {
        yield DataState.pending();

        final weather = await _weatherRepository.fetchWeather(event.cityName);
        yield DataState.complete(weather);
      } catch (e) {
        yield (DataState.failure('Couldn\'t fetch weather.'));
      }
    }
  }
}
