import 'package:basics_samples/data/model/data_state.dart';
import 'package:basics_samples/data/weather_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:basics_samples/data/model/weather.dart';

class WeatherCubit extends Cubit<DataState<Weather>> {
  final WeatherRepository _weatherRepository;

  WeatherCubit(this._weatherRepository) : super(DataState.initial());

  Future<void> getWeatcher(String cityName) async {
    try {
      emit(const DataState.pending());

      final weather = await _weatherRepository.fetchWeather(cityName);
      emit(DataState.complete(weather));
    } catch (e) {
      emit(DataState.failure('Couldn\'t fetch weather.'));
    }
  }
}
