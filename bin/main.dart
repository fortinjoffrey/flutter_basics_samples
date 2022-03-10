import 'child.dart';
import 'father.dart';

void testFromJson() {
  final childJsonMap = {
    'name': 'child',
  };
  print(Child.fromJson(childJsonMap));

  final fatherJsonMap = {
    'name': 'father',
    'child': {'name': 'child'},
  };

  print(Father.fromJson(fatherJsonMap));
}

void testToJson() {
  final child = Child('child');
  print(child.toJson());

  final father = Father('father', child);
  print(father.toJson());
}

void main() {
  testFromJson();
  testToJson();
}
