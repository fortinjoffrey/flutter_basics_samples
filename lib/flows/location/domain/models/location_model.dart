class LocationModel {
  LocationModel(
    this.latitude,
    this.longitude,
  );

  /// Latitude in degrees
  final double? latitude;

  /// Longitude, in degrees
  final double? longitude;

  @override
  String toString() => 'LocationModel(latitude: $latitude, longitude: $longitude)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LocationModel && other.latitude == latitude && other.longitude == longitude;
  }

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;
}
