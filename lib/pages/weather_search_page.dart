import 'package:basics_samples/blocs/weather/weather_bloc.dart';
import 'package:basics_samples/blocs/weather/weather_event.dart';
import 'package:basics_samples/data/model/data_state.dart';
import 'package:basics_samples/data/model/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherSearchPage extends StatefulWidget {
  @override
  _WeatherSearchPageState createState() => _WeatherSearchPageState();
}

class _WeatherSearchPageState extends State<WeatherSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Search"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocConsumer<WeatherBloc, DataState<Weather>>(
          // Reacts to new state
          // listener cb is not part of build process
          listener: (context, state) {
            state.maybeWhen(
              failure: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                  ),
                );
              },
              orElse: () {},
            );
          },
          // Builder is called when a new state is emited
          builder: (context, state) {
            return state.when(
              initial: () => Center(child: CityInputField()),
              pending: () => Center(child: CircularProgressIndicator()),
              failure: (_) => Center(child: CityInputField()),
              complete: (weather) => _WeatherDataWidget(weather: weather),
            );
          },
        ),
      ),
    );
  }
}

class _WeatherDataWidget extends StatelessWidget {
  const _WeatherDataWidget({
    Key? key,
    required this.weather,
  }) : super(key: key);

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          weather.cityName,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          // Display the temperature with 1 decimal place
          "${weather.temperatureCelsius.toStringAsFixed(1)} °C",
          style: TextStyle(fontSize: 80),
        ),
        CityInputField(),
      ],
    );
  }
}

class CityInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: (value) => _submitCityName(context, value),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Enter a city",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  void _submitCityName(BuildContext context, String cityName) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);

    weatherBloc.add(WeatherEvent.getWeather(cityName));
  }
}
