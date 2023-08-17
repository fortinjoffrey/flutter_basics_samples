import 'package:flutter/material.dart';

class ExampleRotateAndScale extends StatefulWidget {
  @override
  _ExampleRotateAndScaleState createState() => _ExampleRotateAndScaleState();
}

class _ExampleRotateAndScaleState extends State<ExampleRotateAndScale> {
  double rotation = 0;
  double previousRotation = 0;
  double scaleX = 1;
  double previousScale = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          title: Text('Rotate and Scale'),
        ),
      body: Center(
        child: Transform(
          transform: Matrix4.identity()
            ..rotateZ(rotation)
            ..scale(scaleX),
          alignment: FractionalOffset.center,
          child: GestureDetector(
            onScaleStart: (details) {
              previousRotation = rotation;
              previousScale = scaleX;
            },
            onScaleUpdate: (details) {
              setState(() {
                rotation = previousRotation + details.rotation;
                scaleX = previousScale * details.scale;
              });
            },
            child: Container(
              color: Colors.indigo,
              height: 200.0,
              width: 200.0,
            ),
          ),
        ),
      ),
    );
  }
}
