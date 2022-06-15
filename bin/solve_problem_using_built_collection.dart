import 'package:built_collection/built_collection.dart';

import 'person.dart';

void main() {
  final BuiltList<Person> persons = BuiltList([Person('John'), Person('Jane')]);

  final BuiltList<Person> modifiedPersons = persons.rebuild(
    (p) => p..[0] = Person('Bob'),
  );

  print(modifiedPersons); // prints [Person(name: Bob), Person(name: Jane)]
  print(persons);         // prints [Person(name: John), Person(name: Jane)]
}
