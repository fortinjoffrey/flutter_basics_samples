import 'package:basics_samples/change_notifiers/weather/weather_state.dart';
import 'package:basics_samples/data/weather_repository.dart';
import 'package:flutter/foundation.dart';

class WeatherChangeNotifier extends ChangeNotifier {
  WeatherChangeNotifier({required WeatherRepository weatherRepository})
      : _weatherRepository = weatherRepository,
        _weatherState = WeatherInitial();

  WeatherState _weatherState;
  final WeatherRepository _weatherRepository;

  WeatherState get state => _weatherState;

  Future<void> getWeather(String cityname) async {
    _weatherState = WeatherLoading();
    notifyListeners();

    try {
      final weather = await _weatherRepository.fetchWeather(cityname);
      _weatherState = WeatherLoaded(weather);
    } catch (e) {
      _weatherState = WeatherError('Couldn\'t fetch weather.');
    }

    notifyListeners();
  }
}
