import 'package:quiver/core.dart';

import 'character.dart';
import 'foo.dart';
import 'person.dart';

void main() {
  // --- Problem without neither optional nor freezed
  final foo1 = Foo(bar: 'baz');
  final foo2 = foo1.copyWith(bar: null);
  
  print(foo1.bar); // 'baz'
  print(foo2.bar); // 'baz' // WRONG!

  // --- With optional ---
  final character1 = Character(name: 'Bob', pseudo: '', age: 10);
  final character2 = character1.copyWith(name: Optional.fromNullable(null));
  final character3 = character1.copyWith(name: null, age: null);

  print('name: ${character1.name}, age: ${character1.age}'); // 'Bob, 10'
  print('name: ${character2.name}, age: ${character2.age}'); // 'null, 10'
  print('name: ${character3.name}, age: ${character3.age}'); // 'Bob, 10'

  // --- Using freezed data classes ---
  final person1 = Person(name: 'James');
  final person2 = person1.copyWith(name: null);

  print(person1.name); // 'James'
  print(person2.name); // 'null'
}