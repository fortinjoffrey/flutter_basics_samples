import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Water Tracker',
      home: ShowCaseWidget(
        onComplete: (p0, p1) {
          print('onComplete');
          print(p0);
          print(p1);
        },
        onStart: (p0, p1) {
          print('onStart');
          print(p0);
          print(p1);
        },
        onFinish: () {
          print('onFinish');
        },
        builder: Builder(
          builder: (context) => HomePage(),
        ),
      ),
    );
  }
}
