import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'filter.dart';

class FilterGroup {
  const FilterGroup({
    required this.name,
    required this.filters,
  });

  final String name;
  final List<Filter> filters;

  FilterGroup copyWith({
    String? name,
    List<Filter>? filters,
  }) {
    return FilterGroup(
      name: name ?? this.name,
      filters: filters ?? this.filters,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'filters': filters.map((x) => x.toMap()).toList(),
    };
  }

  factory FilterGroup.fromMap(Map<String, dynamic> map) {
    return FilterGroup(
      name: map['name'] ?? '',
      filters: List<Filter>.from(map['filters']?.map((x) => Filter.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory FilterGroup.fromJson(String source) => FilterGroup.fromMap(json.decode(source));

  @override
  String toString() => 'FilterGroup(name: $name, filters: $filters)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FilterGroup && other.name == name && listEquals(other.filters, filters);
  }

  @override
  int get hashCode => name.hashCode ^ filters.hashCode;
}
