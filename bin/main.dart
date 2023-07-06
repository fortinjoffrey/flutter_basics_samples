void main(List<String> arguments) {
  final (int a, int b) = swap((3, 5));

  print(a);
  print(b);

  // RECORDS -------------------------------------------------------------------
  print(swap((3, 5)));
  print(swapNamed((a: 3, b: 5)));

  final names = ['John', 'Doe', 'Marc'];
  // ---------------------------------------------------------------------------

  // PATTERN -------------------------------------------------------------------
  final [_, String n2, _] = names;
  print(n2);

  final map = {
    'name': 'James',
    'age': 21,
  };

  final {'name': name, 'age': age} = map;
  print(name);
  print(age);
  // ---------------------------------------------------------------------------

  // SWITCH --------------------------------------------------------------------
  print(oldSwitch(1));
  print(newSwitch(1));
  print(oldSwitch(5));
  print(newSwitch(5));
  // ---------------------------------------------------------------------------

  // SEALED CLASS --------------------------------------------------------------
  testSealedClass(CompleteState(4, data: "data1"));

  // ---------------------------------------------------------------------------
}

// RECORDS
//https://dart.dev/language/records
(int, int) swap((int, int) record) {
  var (a, b) = record;
  record.$1;
  record.$2;
  return (b, a);
}

({int a, int b}) swapNamed(({int a, int b}) record) {
  return (a: record.b, b: record.a);
}

int oldSwitch(int value) {
  switch (value) {
    case 0:
      return 0;
    case 1:
      return 1;
    default:
      return -1;
  }
}

int newSwitch(int value) {
  return switch (value) {
    0 => 0,
    1 => 1,
    _ => -1,
  };
}

abstract class Animal {}

class PetAnimal extends Animal {
  final String owner;

  PetAnimal(this.owner);
}

class WildAnimal extends Animal {
  final String fatherName;
  final String motherName;

  WildAnimal(this.fatherName, this.motherName);
}

String switchOnType(Animal animal) {
  return switch (animal) {
    PetAnimal() => "",
    WildAnimal(motherName: final label) => label,
    _ => throw (UnimplementedError()),
  };
}

sealed class State {}

class InitialState extends State {
  final String s;

  InitialState(this.s);
}

class LoadingState extends State {}

class CompleteState extends State {
  final String data;
  final int data2;

  CompleteState(this.data2, {required this.data});
}

class ErrorState extends State {}

void testSealedClass(final State state) {
  print(switch (state) {
    InitialState() => 'initial state',
    LoadingState _ => 'loading state',
    CompleteState _ => {
      'titi',
      'complete state, data:${state.data}',
    },
    ErrorState _ => 'initial state'
  });
}
