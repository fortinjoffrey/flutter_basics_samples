import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'person.dart';

void main() {
  final IList<Person> persons = IList([Person('John'), Person('Jane')]);

  final IList<Person> modifiedPersons = (persons.unlock..[0] = Person('Bob')).lock;

  print(modifiedPersons); // prints [Person(name: Bob), Person(name: Jane)]
  print(persons); // prints [Person(name: John), Person(name: Jane)]
}
