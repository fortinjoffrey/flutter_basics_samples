import 'package:basics_samples/data/model/weather.dart';
import 'package:basics_samples/data/weather_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc({required WeatherRepository weatherRepository})
      : _weatherRepository = weatherRepository,
        super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) async {
      if (event is GetWeatherEvent) {
        try {
          emit(WeatherLoading());
          final weather = await _weatherRepository.fetchWeather(event.cityname);
          emit(WeatherLoaded(weather));
        } catch (e) {
          emit(WeatherError('Couldn\'t fetch weather.'));
        }
      }
    });
  }

  final WeatherRepository _weatherRepository;
}
