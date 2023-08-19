import 'package:flutter/material.dart';

class ExampleRotateScaleTranslate extends StatefulWidget {
  @override
  _ExampleRotateScaleTranslateState createState() => _ExampleRotateScaleTranslateState();
}

class _ExampleRotateScaleTranslateState extends State<ExampleRotateScaleTranslate> {
  double rotation = 0;
  double previousRotation = 0;
  double scaleX = 1;
  double previousScale = 1;
  double x = 1;
  double y = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          title: Text('Rotate, scale, translate'),
        ),
      body: Center(
        child: Transform(
          transform: Matrix4.identity()
            ..rotateZ(rotation)
            ..scale(scaleX)
            ..translate(x, y),
          alignment: FractionalOffset.center,
          child: GestureDetector(
            onScaleStart: (details) {
              previousRotation = rotation;
              previousScale = scaleX;
            },
            onScaleUpdate: (details) {
              print(details.focalPoint.dx);
              setState(() {
                rotation = previousRotation + details.rotation;
                scaleX = previousScale * details.scale;
                y = y + details.focalPointDelta.dy;
                x = x + details.focalPointDelta.dx;
              });
            },
            child: Container(
              color: Colors.pink,
              height: 200.0,
              width: 200.0,
            ),
          ),
        ),
      ),
    );
  }
}
