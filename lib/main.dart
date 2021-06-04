import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print('MyApp build called');
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyMainPage(),
    );
  }
}

class MyMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('MyMainPage build called');
    return MyHomePage();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('MyHome build called');
    final orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.landscape) {
      return Center(child: Text('Landscape'));
    } else {
      return Center(child: Text('Portrait'));
    }
  }
}
