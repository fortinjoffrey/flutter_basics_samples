import 'package:basics_samples/change_notifiers/weather/weather_state.dart';
import 'package:basics_samples/main.dart';
import 'package:basics_samples/models/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeatherSearchPage extends StatefulWidget {
  @override
  _WeatherSearchPageState createState() => _WeatherSearchPageState();
}

class _WeatherSearchPageState extends State<WeatherSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather search page"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(weatherChangeNotifierProvider).state;
            print(state);
            if (state is WeatherInitial)
              return _WeatherInitial();
            else if (state is WeatherLoading)
              return _WeatherLoading();
            else if (state is WeatherLoaded)
              return _WeatherComplete(weather: state.weather);
            else if (state is WeatherError)
              return _WeatherError(message: state.message);
            else {
              return _WeatherInitial();
            }
          },
        ),
      ),
    );
  }
}

class _WeatherInitial extends StatelessWidget {
  const _WeatherInitial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: _SearchInputs());
  }
}

class _WeatherLoading extends StatelessWidget {
  const _WeatherLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}

class _WeatherError extends StatelessWidget {
  const _WeatherError({Key? key, required this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _SearchInputs(),
        Text(message),
      ],
    );
  }
}

class _WeatherComplete extends StatelessWidget {
  const _WeatherComplete({
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
        _SearchInputs(),
      ],
    );
  }
}

class _SearchInputs extends ConsumerStatefulWidget {
  @override
  ConsumerState<_SearchInputs> createState() => _SearchInputsState();
}

class _SearchInputsState extends ConsumerState<_SearchInputs> {
  String _cityname = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            onSubmitted: (_) => _submitSearch(context, _cityname),
            onChanged: (value) => _cityname = value,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: "Enter a city",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: ElevatedButton(
              onPressed: () {
                _submitSearch(context, _cityname);
              },
              child: const Text('Search'),
            ),
          ),
        ],
      ),
    );
  }

  void _submitSearch(BuildContext context, String cityName) {
    final weatherChangeNotifier = ref.read(weatherChangeNotifierProvider.notifier);

    weatherChangeNotifier.getWeather(cityName);
  }
}
