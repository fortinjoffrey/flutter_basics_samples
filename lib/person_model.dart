import 'package:flutter/foundation.dart';

class PersonModel extends ChangeNotifier {
  PersonModel(this._counter, this._name);

  int _counter;
  int get counter => _counter;

  String _name;
  String get name => _name;

  void increment() {
    _counter++;
    notifyListeners();
  }

  void changeName(String newName) {
    _name = newName;
    notifyListeners();
  }
}
