import 'dart:math';

import 'package:flutter/material.dart';

class ChangePositionOnPanRotateScaleWithComponentStateful extends StatefulWidget {
  @override
  _ChangePositionOnPanRotateScaleWithComponentStatefulState createState() =>
      _ChangePositionOnPanRotateScaleWithComponentStatefulState();
}

class _ChangePositionOnPanRotateScaleWithComponentStatefulState
    extends State<ChangePositionOnPanRotateScaleWithComponentStateful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Position onPan Rotate Scale Component Stateful'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.green,
                  ),
                  MovablePositioned(
                    top: 100,
                    left: 100,
                    rotation: pi/4,
                    scaleX: .5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MovablePositioned extends StatefulWidget {
  const MovablePositioned({
    super.key,
    required this.top,
    required this.left,
    this.rotation = 0,
    this.scaleX = 1,
  });

  final double top;
  final double left;
  final double rotation;
  final double scaleX;

  @override
  State<MovablePositioned> createState() => MovablePositionedState();
}

class MovablePositionedState extends State<MovablePositioned> {
  late double left = widget.left;
  late double top = widget.top;
  late double rotation = widget.rotation;
  late double previousRotation = widget.rotation;
  late double scaleX = widget.scaleX;
  late double previousScale = widget.scaleX;

  @override
  Widget build(BuildContext context) {
    print('top:${top.round()}/left:${left.round()}');
    return Positioned(
      top: top,
      left: left,
      child: GestureDetector(
        onScaleStart: (details) {
          previousRotation = rotation;
          previousScale = scaleX;
        },
        onScaleUpdate: (details) {
          setState(() {
            rotation = previousRotation + details.rotation;
            final deg = rotation * 180 / pi;
            print('rotation:$deg');
            scaleX = previousScale * details.scale;
            print('scaleX:$scaleX');
            top = top + details.focalPointDelta.dy;
            left = left + details.focalPointDelta.dx;
          });
        },
        child: Transform(
          transform: Matrix4.identity()
            ..rotateZ(rotation)
            ..scale(scaleX),
          alignment: FractionalOffset.center,
          child: Container(
            color: Colors.black,
            height: 200.0,
            width: 200.0,
          ),
        ),
      ),
    );
  }
}
