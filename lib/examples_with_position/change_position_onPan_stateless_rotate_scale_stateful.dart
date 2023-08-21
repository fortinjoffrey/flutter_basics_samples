import 'dart:math';

import 'package:flutter/material.dart';

class ChangePositionOnPanStatelessRotateScaleStateful extends StatefulWidget {
  @override
  _ChangePositionOnPanRotateScaleWithComponentStatefulState createState() =>
      _ChangePositionOnPanRotateScaleWithComponentStatefulState();
}

class _ChangePositionOnPanRotateScaleWithComponentStatefulState
    extends State<ChangePositionOnPanStatelessRotateScaleStateful> {
  double positionedWidgetTop = 100;
  double positionedWidgetLeft = 100;

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
              child: ClipRRect(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.green,
                    ),
                    MovablePositioned(
                      top: positionedWidgetTop,
                      left: positionedWidgetLeft,
                      onPositionChanged: (double left, double top) {
                        setState(() {
                          positionedWidgetLeft = left;
                          positionedWidgetTop = top;
                        });
                      },
                      rotation: pi / 4,
                      scaleX: .5,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

typedef OnPositionChanged = void Function(double left, double top);

class MovablePositioned extends StatefulWidget {
  const MovablePositioned({
    super.key,
    required this.top,
    required this.left,
    this.rotation = 0,
    this.scaleX = 1,
    required this.onPositionChanged,
  });

  final double top;
  final double left;
  final double rotation;
  final double scaleX;
  final OnPositionChanged onPositionChanged;

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
  void didUpdateWidget(covariant MovablePositioned oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Parent wants to override this widget position
    if (widget.top != top || widget.left != left) {
      setState(() {
        left = widget.left;
        top = widget.top;
      });
    }
  }

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
            scaleX = previousScale * details.scale;
          });
          final top = widget.top + details.focalPointDelta.dy;
          final left = widget.left + details.focalPointDelta.dx;
          widget.onPositionChanged(left, top);
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
