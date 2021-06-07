int multiply(int a, int b) => a * b;

int substract({required int a, required int b}) => a - b;

int getInt(int? a) => a ?? -1;

class Person {
  Person({required this.age, required this.favoriteColor});

  final int age;
  String? favoriteColor;

  String getFavoriteColor() => favoriteColor ?? 'None';
}

void main() {
  // Parameters exercice
  print(multiply(3, 2)); // both paramas must be provided
  print(substract(a: 4, b: 3)); // both params must be provided

  // Créer une fonction qui retourne -1 si la valeur du int fournit est null
  print(getInt(2)); // should print 2
  print(getInt(null)); // should print -1

  // null safety and keywords excercice
  // age can never be null, favoriteColor can
  // favoriteColor might change, age must never change
  final person = Person(age: 14, favoriteColor: null);
  print(person.getFavoriteColor()); // print should be 'None' if favorite is null
  person.favoriteColor = 'Blue';
  print(person.getFavoriteColor()); // print should be 'Blue'
}
