class User {
  final String name;
  final int age;
  final String id;

  const User({
    required this.name,
    required this.age,
    required this.id,
  });

  @override
  String toString() => 'User(name: $name, age: $age, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is User &&
      other.name == name &&
      other.age == age &&
      other.id == id;
  }

  @override
  int get hashCode => name.hashCode ^ age.hashCode ^ id.hashCode;
}
