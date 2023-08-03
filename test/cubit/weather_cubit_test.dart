import 'package:basics_samples/cubit/weather_cubit.dart';
import 'package:basics_samples/data/model/weather.dart';
import 'package:basics_samples/data/weather_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

abstract class Fixtures {
  static const Weather mockParisWeather = Weather(cityName: 'Paris', temperatureCelsius: 20.2);
}

void main() {
  late WeatherRepository mockWeatherRepository;
  late WeatherCubit weatherCubit;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    weatherCubit = WeatherCubit(mockWeatherRepository);
  });

  blocTest<WeatherCubit, WeatherState>(
    'emits $WeatherLoading while fetching and $WeatherLoaded on weather fetched',
    build: () {
      when(() => mockWeatherRepository.fetchWeather(any())).thenAnswer((_) async => Fixtures.mockParisWeather);
      return weatherCubit;
    },
    verify: (cubit) {
      verify(() => mockWeatherRepository.fetchWeather('Paris')).called(1);
    },
    act: (cubit) => cubit.getWeatcher('Paris'),
    expect: () => const <WeatherState>[
      WeatherLoading(),
      WeatherLoaded(Fixtures.mockParisWeather),
    ],
  );

  blocTest<WeatherCubit, WeatherState>(
    'emits $WeatherLoading while fetching and $WeatherError when the repository throws',
    build: () {
      when(() => mockWeatherRepository.fetchWeather('Paris')).thenThrow(Exception());
      return weatherCubit;
    },
    act: (cubit) => cubit.getWeatcher('Paris'),
    expect: () => const <WeatherState>[
      WeatherLoading(),
      WeatherError('Couldn\'t fetch weather.'),
    ],
  );
}
