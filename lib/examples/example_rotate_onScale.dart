import 'package:flutter/material.dart';

class ExampleRotateOnScale extends StatefulWidget {
  @override
  _ExampleRotateOnScaleState createState() => _ExampleRotateOnScaleState();
}

class _ExampleRotateOnScaleState extends State<ExampleRotateOnScale> {
  double rotation = 0;
  double previousRotation = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rotate onScale'),
      ),
      body: Center(
        child: Transform(
          transform: Matrix4.identity()..rotateZ(rotation),
          alignment: FractionalOffset.center,
          child: GestureDetector(
            onScaleStart: (details) {
              previousRotation = rotation;
            },
            onScaleUpdate: (details) {
              setState(() {
                rotation = previousRotation + details.rotation;
              });
            },
            child: Container(
              color: Colors.orange,
              height: 200.0,
              width: 200.0,
            ),
          ),
        ),
      ),
    );
  }
}
