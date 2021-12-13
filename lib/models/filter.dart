import 'dart:convert';

class Filter {
  const Filter({
    required this.name,
    this.selected = false,
  });

  final String name;
  final bool selected;

  Filter copyWith({
    String? name,
    bool? selected,
  }) {
    return Filter(
      name: name ?? this.name,
      selected: selected ?? this.selected,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'selected': selected,
    };
  }

  factory Filter.fromMap(Map<String, dynamic> map) {
    return Filter(
      name: map['name'] ?? '',
      selected: map['selected'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Filter.fromJson(String source) => Filter.fromMap(json.decode(source));

  @override
  String toString() => 'Filter(name: $name, selected: $selected)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Filter && other.name == name && other.selected == selected;
  }

  @override
  int get hashCode => name.hashCode ^ selected.hashCode;
}
