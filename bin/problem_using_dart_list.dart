import 'person.dart';

void main() {
  final List<Person> persons = [Person('John'), Person('Jane')];
  final modifiedPersons = persons.map((e) => e).toList();
  modifiedPersons[0].name = 'Bob';
  print(modifiedPersons); // prints [Person(name: Bob), Person(name: Jane)]
  print(persons);         // prints [Person(name: Bob), Person(name: Jane)]
}

// PROBLEM: by changing modifiedPersons list, the original persons has been affected aswell
// We could use this instruction :   final modifiedPersons = persons.map((e) => e).toList();
// But this is error prone since: 
//    - We still can compile
//    - The developer has to know that he needs to copy the list content
//    - We will have problems for nested collections, we'll have to perform nested maps
