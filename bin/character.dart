import 'package:quiver/core.dart';

class Character {
  final String? name;
  final String pseudo;
  final int age;

  Character({
    this.name,
    required this.pseudo,
    required this.age,
  });

  Character copyWith({
    Optional<String?>? name,
    Optional<String>? pseudo,
    int? age,
  }) {
    return Character(
      name: name == null ? this.name : name.orNull,
      pseudo: pseudo == null ? this.pseudo : pseudo.value,
      age: age ?? this.age, 
      // What happens when age's class property becomes nullable ?
      // when age parameter becomes null then age equals this.age 
      // which can be null or not
      // Let's say this.age is 10, we call copyWith(age: null)
      // We expect the result Character's age to be null which is not true
      // Character's age will be equal to 10
      // One solution is to transfor int? age with Optional<int?>? age
      // or make every parameter of copyWith Optional<T>? for setting non nullable properties
    );
  }
}
