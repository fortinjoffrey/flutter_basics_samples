import 'package:flutter/material.dart';

class ExampleScaleOnPan extends StatefulWidget {
  @override
  _ExampleScaleOnPanState createState() => _ExampleScaleOnPanState();
}

class _ExampleScaleOnPanState extends State<ExampleScaleOnPan> {
  double x = 1;
  double y = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scale onPan'),
      ),
      body: Center(
        child: Transform(
          transform: Matrix4.identity()..scale(x, y),
          // EQUIVALENT
          // transform: Matrix4(
          //     x,0,0,0,
          //     0,y,0,0,
          //     0,0,1,0,
          //     0,0,0,1,
          // ),
          alignment: FractionalOffset.center,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                y = y - details.delta.dy / 200;
                x = x + details.delta.dx / 200;
              });
            },
            child: Container(
              color: Colors.blue,
              height: 200.0,
              width: 200.0,
            ),
          ),
        ),
      ),
    );
  }
}
