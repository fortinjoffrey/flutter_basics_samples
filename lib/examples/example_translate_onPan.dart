import 'package:flutter/material.dart';

class ExampleTranslateOnPan extends StatefulWidget {
  @override
  _ExampleTranslateOnPanState createState() => _ExampleTranslateOnPanState();
}

class _ExampleTranslateOnPanState extends State<ExampleTranslateOnPan> {
  double x = 1;
  double y = 1;
  // double z = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          title: Text('Translate onPan'),
        ),
      body: Center(
        child: Center(
          child: Transform(
            transform: Matrix4.identity()..translate(x, y),
            // EQUIVALENT
            // transform: Matrix4(
            //     1,0,0,0,
            //     0,1,0,0,
            //     0,0,1,0,
            //     x,y,0,1,
            // ),
            alignment: FractionalOffset.center,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  y = y + details.delta.dy;
                  x = x + details.delta.dx;
                });
              },
              child: Container(
                color: Colors.green,
                height: 200.0,
                width: 200.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
