class User {
  final String name;
  final int age;

  const User({
    required this.name,
    required this.age,
  });

  @override
  String toString() => 'User(name: $name, age: $age)';
}
