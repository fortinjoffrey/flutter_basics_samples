import 'dart:convert';

class Vehicle {
  final String id;
  final String licensePlate;
  final int year;
  Vehicle({
    required this.id,
    required this.licensePlate,
    required this.year,
  });

  Vehicle copyWith({
    String? id,
    String? licensePlate,
    int? year,
  }) {
    return Vehicle(
      id: id ?? this.id,
      licensePlate: licensePlate ?? this.licensePlate,
      year: year ?? this.year,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'licensePlate': licensePlate});
    result.addAll({'year': year});
  
    return result;
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      id: map['id'] ?? '',
      licensePlate: map['licensePlate'] ?? '',
      year: map['year']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Vehicle.fromJson(String source) => Vehicle.fromMap(json.decode(source));

  @override
  String toString() => 'Vehicle(id: $id, licensePlate: $licensePlate, year: $year)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Vehicle &&
      other.id == id &&
      other.licensePlate == licensePlate &&
      other.year == year;
  }

  @override
  int get hashCode => id.hashCode ^ licensePlate.hashCode ^ year.hashCode;
}
