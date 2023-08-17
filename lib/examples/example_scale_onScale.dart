import 'package:flutter/material.dart';

class ExampleScaleOnScale extends StatefulWidget {
  @override
  _ExampleScaleOnScaleState createState() => _ExampleScaleOnScaleState();
}

class _ExampleScaleOnScaleState extends State<ExampleScaleOnScale> {
  double scaleX = 1;
  double previousScale = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          title: Text('Scale onScale'),
        ),
      body: Center(
        child: Transform(
          transform: Matrix4.identity()..scale(scaleX),
          // EQUIVALENT
          // transform: Matrix4(
          //     scaleX,0,0,0,
          //     0,scaleX,0,0,
          //     0,0,1,0,
          //     0,0,0,1,
          // ),
          alignment: FractionalOffset.center,
          child: GestureDetector(
            onScaleStart: (details) {
              previousScale = scaleX;
            },
            onScaleUpdate: (details) {
              setState(() {
                scaleX = previousScale * details.scale;
              });
            },
            child: Container(
              color: Colors.purple,
              height: 200.0,
              width: 200.0,
            ),
          ),
        ),
      ),
    );
  }
}
