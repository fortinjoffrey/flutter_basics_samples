

import 'package:flutter/material.dart';

class UserInheritedWidgetData {
  String name;
  final int age;

  UserInheritedWidgetData({ required this.name, required this.age});
}

class UserInheritedWidget extends InheritedWidget {

  UserInheritedWidget({Key? key, required this.data, required this.child}) : super(key: key, child: child);

  final Widget child;
  final UserInheritedWidgetData data;

  @override
  bool updateShouldNotify(covariant UserInheritedWidget oldWidget) {
    return oldWidget.data != data;
  } 

  static UserInheritedWidgetData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UserInheritedWidget>()!.data;
  }
}