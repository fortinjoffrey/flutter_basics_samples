import 'package:basics_samples/change_notifiers/weather/weather_state.dart';
import 'package:basics_samples/data/weather_repository.dart';
import 'package:state_notifier/state_notifier.dart';

class WeatherStateNotifier extends StateNotifier<WeatherState> {
  WeatherStateNotifier({required WeatherRepository weatherRepository})
      : _weatherRepository = weatherRepository,
        super(WeatherInitial());

  final WeatherRepository _weatherRepository;

  Future<void> getWeather(String cityname) async {
    state = WeatherLoading();

    try {
      final weather = await _weatherRepository.fetchWeather(cityname);
      state = WeatherLoaded(weather);
    } catch (e) {
      state = WeatherError('Couldn\'t fetch weather.');
    }
  }
}
