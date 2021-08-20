import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:basics_samples/cubit/weather_cubit.dart';
import 'package:basics_samples/data/weather_repository.dart';
import 'package:basics_samples/pages/weather_search_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: BlocProvider(
        // Create and provide a WeatherCubit instance down the widget tree
        create: (context) => WeatherCubit(FakeWeatherRepository()),
        child: WeatherSearchPage(),
      ),
    );
  }
}
