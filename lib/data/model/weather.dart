class Weather {
  final String cityName;
  final double temperatureCelsius;

  const Weather({
    required this.cityName,
    required this.temperatureCelsius,
  });

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Weather && o.cityName == cityName && o.temperatureCelsius == temperatureCelsius;
  }

  @override
  int get hashCode => cityName.hashCode ^ temperatureCelsius.hashCode;

  @override
  String toString() => 'Weather(cityName: $cityName, temperatureCelsius: $temperatureCelsius)';
}
