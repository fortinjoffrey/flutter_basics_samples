import 'package:flutter/material.dart';

class ChangePositionOnPanWithComponentStateful extends StatefulWidget {
  @override
  _ChangePositionOnPanWithComponentStatefulState createState() => _ChangePositionOnPanWithComponentStatefulState();
}

class _ChangePositionOnPanWithComponentStatefulState extends State<ChangePositionOnPanWithComponentStateful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Position onPan  Component Stateful'),
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
  });

  final double top;
  final double left;

  @override
  State<MovablePositioned> createState() => MovablePositionedState();
}

int counter = 0;

class MovablePositionedState extends State<MovablePositioned> {
  late double left = widget.left;
  late double top = widget.top;

  @override
  Widget build(BuildContext context) {
    counter++;
    print('counter: $counter');
    print('top: $top');
    return Positioned(
      top: top,
      left: left,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            top = top + details.delta.dy;
            left = left + details.delta.dx;
          });
        },
        // onPanUpdate: (details) {
        //   setState(() {
        //     top = top + details.delta.dy;
        //     left = left + details.delta.dx;
        //   });
        // },
        child: Container(
          color: Colors.black,
          height: 200.0,
          width: 200.0,
        ),
      ),
    );
  }
}
