import 'package:basics_samples/change_notifiers/weather/weather_change_notifier.dart';
import 'package:basics_samples/data/weather_repository.dart';
import 'package:basics_samples/pages/weather_search_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: ChangeNotifierProvider(
        // Create and provide a WeatherChangeNotifier instance down the widget tree
        create: (context) => WeatherChangeNotifier(weatherRepository: FakeWeatherRepository()),
        child: WeatherSearchPage(),
      ),
    );
  }
}
