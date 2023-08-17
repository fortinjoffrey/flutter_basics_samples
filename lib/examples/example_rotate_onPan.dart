import 'package:flutter/material.dart';

class ExampleRotateOnPan extends StatefulWidget {
  @override
  _ExampleRotateOnPanState createState() => _ExampleRotateOnPanState();
}

class _ExampleRotateOnPanState extends State<ExampleRotateOnPan> {
  double x = 0;
  double y = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rotate onPan'),
      ),
      body: Center(
        child: Transform(
          transform: Matrix4.identity()
            ..rotateX(x)
            ..rotateY(y),
          alignment: FractionalOffset.center,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                y = y - details.delta.dx / 200;
                x = x + details.delta.dy / 200;
              });
            },
            child: Container(
              color: Colors.red,
              height: 200.0,
              width: 200.0,
            ),
          ),
        ),
      ),
    );
  }
}
