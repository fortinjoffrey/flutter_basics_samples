import 'package:built_collection/built_collection.dart';

// We should use const here but const dart collection equality works before of compiler optimisation (see const keyword)
final number = 1;
final name = 'foo';

void main() {
  dartCollectionsEquality();
  builtCollectionEquality();

  dartList();
  builtCollectionList();

  dartMap();
  builtCollectionMap();
}

void dartCollectionsEquality() {
  final List<int> list1 = [0, number, 2];
  final List<int> list2 = [0, number, 2];

  print('dartCollectionsEquality');
  print(list1 == list2); // returns false

  final Map<String, dynamic> map1 = {'name': name};
  final Map<String, dynamic> map2 = {'name': name};

  print(map1 == map2); // returns false
}

void builtCollectionEquality() {
  final BuiltList<int> list1 = BuiltList([0, number, 2]);
  final BuiltList<int> list2 = BuiltList([0, number, 2]);

  print('builtCollectionEquality');
  print(list1 == list2); // returns true

  final Map<String, dynamic> map1 = {'name': name};
  final Map<String, dynamic> map2 = {'name': name};

  print(map1 == map2); // returns true
}

void dartList() {
  final List<int> list = [0, number, 2];

  list.add(3);
  list[0] = -1;

  print('dartList list modified: $list'); // returns [-1, 1, 2, 3]
}

void builtCollectionList() {
  final BuiltList<int> list = BuiltList([0, number, 2]);
  // list.add(3);    // add Does not exist in BuiltList
  // list[0] = -1;   // [] operator does not exist in BuiltList

  // OPTION 1: use rebuild method
  final BuiltList<int> newList = list.rebuild((o) => o
    ..add(3)
    ..[0] = -1);

  print('builtCollectionList using rebuild list modified: $newList'); 

  // OPTION 2: use toBuilder() then build() methods
  final ListBuilder<int> listBuilder = list.toBuilder();
  listBuilder.add(3);
  listBuilder[0] = -1;
  final BuiltList<int> newList2 = listBuilder.build();
  print('builtCollectionList using toBuilder() list modified: $newList2');
}

void dartMap() {
  final Map<String, dynamic> map = {'name': 'foo'};

  map['name'] = 'bar';

  print('dartMap map modified: $map');
}

void builtCollectionMap() {
  final BuiltMap<String, dynamic> map = BuiltMap({'name': 'foo'});

  // map['name'] = 'bar'; // [] operator does not exist in BuiltList

  // OPTION 1: use rebuild method
  final BuiltMap<String, dynamic> newMap = map.rebuild((o) => o..['name'] = 'bar');

  print('builtCollectionMap usgin rebuild map: $map');
  print('builtCollectionMap usgin rebuild newMap: $newMap');

  // OPTION 2: use toBuilder() then build() methods
  final MapBuilder<String, dynamic> mapBuilder = map.toBuilder();

  mapBuilder['name'] = 'bar';
  final BuiltMap<String, dynamic> newMap2 = mapBuilder.build();
  print('builtCollectionMap using toBuilder() map: $map');
  print('builtCollectionMap using toBuilder() newMap: $newMap2');
}
