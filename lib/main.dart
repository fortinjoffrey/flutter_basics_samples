import 'package:basics_samples/change_notifiers/weather/weather_change_notifier.dart';
import 'package:basics_samples/data/weather_repository.dart';
import 'package:basics_samples/pages/weather_search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final weatherChangeNotifierProvider = ChangeNotifierProvider<WeatherChangeNotifier>(
  (ref) => WeatherChangeNotifier(weatherRepository: FakeWeatherRepository()),
);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Material App',
        home: WeatherSearchPage(),
      ),
    );
  }
}
