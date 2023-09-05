import 'package:flutter/material.dart';

/// The person screen.
class PersonScreen extends StatelessWidget {
  /// Creates a [PersonScreen].
  const PersonScreen({
    super.key,
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  @override
  Widget build(BuildContext context) {
    final Person person = Person(id: id, name: name);
    return Scaffold(
      appBar: AppBar(title: Text(person.name)),
      body: Text('${person.id} is ${person.age} years old'),
    );
  }
}

class Person {
  const Person({
    required this.id,
    required this.name,
  });
  final String id;
  final String name;

  int get age => 42;
}
