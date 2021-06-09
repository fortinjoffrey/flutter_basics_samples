import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Person extends ChangeNotifier {
  Person({required String name, Color? favoriteColor})
      : _name = name,
        _favoriteColor = favoriteColor;

  String _name;
  String get name => _name;

  Color? _favoriteColor;
  Color? get favoriteColor => _favoriteColor;

  void changeFavoriteColor(Color? color) {
    _favoriteColor = color;
    notifyListeners();
  }
}
