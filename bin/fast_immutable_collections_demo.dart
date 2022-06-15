import 'package:fast_immutable_collections/fast_immutable_collections.dart';

// We should use const here but const dart collection equality works before of compiler optimisation (see const keyword)
final number = 1;
final name = 'foo';

void main() {
  dartCollectionsEquality();
  fastImmutableCollectionsEquality();

  dartList();
  fastImmutableCollectionsList();

  dartMap();
  fastImmutableCollectionsMap();
}

void dartCollectionsEquality() {
  final List<int> list1 = [0, number, 2];
  final List<int> list2 = [0, number, 2];

  print(list1 == list2); // returns false

  final Map<String, dynamic> map1 = {'name': name};
  final Map<String, dynamic> map2 = {'name': name};

  print(map1 == map2); // returns false
}

void fastImmutableCollectionsEquality() {
  final IList<int> list1 = IList([0, number, 2]);
  final IList<int> list2 = IList([0, number, 2]);

  print(list1 == list2); // returns true

  final IMap<String, dynamic> map1 = IMap({'name': name});
  final IMap<String, dynamic> map2 = IMap({'name': name});

  print(map1 == map2); // returns true
}

void dartList() {
  final List<int> list = [0, number, 2];

  list.add(3);
  list[0] = -1;

  print('dartList modified: $list'); // returns [-1, 1, 2, 3]
}

void fastImmutableCollectionsList() {
  final IList<int> list = IList([0, number, 2]);

  final IList<int> newList = (list.unlock
        ..add(3)
        ..[0] = -1)
      .lock;

  print('fastImmutableCollectionsList list: $list');
  print('fastImmutableCollectionsList newList: $newList');
}

void dartMap() {
  final Map<String, dynamic> map = {'name': name};

  map['name'] = 'bar';

  print('dartMap modified: $map');
}

void fastImmutableCollectionsMap() {
  final IMap<String, dynamic> map = IMap({'name': name});

  final IMap<String, dynamic> newMap = (map.unlock..['name'] = 'bar').lock;

  print('fastImmutableCollectionsMap map: $map');
  print('fastImmutableCollectionsMap new map: $newMap');
}
