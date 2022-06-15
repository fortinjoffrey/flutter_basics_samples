class Person {
  String name;

  Person(this.name);

  @override
  String toString() => 'Person(name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Person &&
      other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}