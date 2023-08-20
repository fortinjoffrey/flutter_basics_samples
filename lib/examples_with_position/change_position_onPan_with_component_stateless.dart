import 'package:flutter/material.dart';

class ChangePositionOnPanWithComponentStateless extends StatefulWidget {
  @override
  _ChangePositionOnPanWithComponentStatelessState createState() => _ChangePositionOnPanWithComponentStatelessState();
}

class _ChangePositionOnPanWithComponentStatelessState extends State<ChangePositionOnPanWithComponentStateless> {
  double positionedWidgetTop = 100;
  double positionedWidgetLeft = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Position onPan Component Stateless'),
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
                    top: positionedWidgetTop,
                    left: positionedWidgetLeft,
                    onPositionChanged: (double left, double top) {
                      setState(() {
                        positionedWidgetLeft = left;
                        positionedWidgetTop = top;
                      });
                    },
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

typedef OnPositionChanged = void Function(double left, double top);

class MovablePositioned extends StatelessWidget {
  const MovablePositioned({
    super.key,
    required this.top,
    required this.left,
    required this.onPositionChanged,
  });

  final double top;
  final double left;
  final OnPositionChanged onPositionChanged;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: GestureDetector(
        onPanUpdate: (details) {
          final top = this.top + details.delta.dy;
          final left = this.left + details.delta.dx;
          onPositionChanged(left, top);
        },
        child: Container(
          color: Colors.black,
          height: 200.0,
          width: 200.0,
        ),
      ),
    );
  }
}
