import 'package:flutter/material.dart';

class ColorInfo extends InheritedWidget {
  ColorInfo({Key? key, required this.colors, required this.child}) : super(key: key, child: child);

  final Widget child;
  final List<Color> colors;

  static ColorInfo? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ColorInfo>();
  }

  @override
  bool updateShouldNotify(ColorInfo oldWidget) {
    return oldWidget.colors != colors;
  }
}
