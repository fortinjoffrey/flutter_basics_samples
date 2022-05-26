import 'package:basics_samples/a_view.dart';
import 'package:flutter/material.dart';

final bRouteObserver = RouteObserver<ModalRoute<void>>();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AView(),
      navigatorObservers: [bRouteObserver],
    );
  }
}
