import 'package:basics_samples/blocs/weather/weather_event.dart';
import 'package:basics_samples/data/model/data_state.dart';
import 'package:basics_samples/data/model/weather.dart';
import 'package:basics_samples/data/weather_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, DataState<Weather>> {
  WeatherBloc({required WeatherRepository weatherRepository})
      : _weatherRepository = weatherRepository,
        super(DataState.initial()) {
    on<WeatherEvent>((event, emit) async {
      await event.when(
        getWeather: (cityName) async {
          try {
            emit(DataState.pending());
            final weather = await _weatherRepository.fetchWeather(event.cityName);
            emit(DataState.complete(weather));
          } catch (e) {
            emit(DataState.failure('Couldn\'t fetch weather.'));
          }
        },
      );
    });
  }

  final WeatherRepository _weatherRepository;
}
