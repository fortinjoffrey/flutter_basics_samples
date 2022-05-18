import 'package:basics_samples/marquee_custom_widget.dart';
import 'package:flutter/material.dart';
// import 'package:marquee_widget/marquee_widget.dart';
// import 'package:marquee/marquee.dart';

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Marquee(
                      startPadding: 100,
                      child: Text(
                          'Pariatur nulla aute consequat aute incididunt occaecat voluptate qui occaecat Lorem do eu.'),
                      textDirection: TextDirection.ltr,
                      backwardAnimation: Curves.easeInOut,
                      forwardAnimation: Curves.easeInOut,
                      animationDuration: Duration(seconds: 6),
                      backDuration: Duration(seconds: 6),
                      pauseDuration: Duration(seconds: 2),
                      directionMarguee: DirectionMarguee.TwoDirection,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
