import 'package:basics_samples/utils/offset_utils.dart';
import 'package:flutter/material.dart';

class ExampleChangePositionOnPan extends StatefulWidget {
  @override
  _ExampleChangePositionOnPanState createState() => _ExampleChangePositionOnPanState();
}

class _ExampleChangePositionOnPanState extends State<ExampleChangePositionOnPan> {
  final widgetKey = GlobalKey();
  final stackKey = GlobalKey();
  static const double initialTop = 100;
  late Offset widgetLocalOffset = Offset(0, initialTop);
  Size? widgetSize;
  bool animatesWidget = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _repositionWidget(withAnimation: false);
    });
  }

  void _repositionWidget({bool withAnimation = true}) {
    final stackSize = getSizeFromKey(stackKey);
    final widgetSize = getSizeFromKey(widgetKey);

    if (stackSize == null || widgetSize == null) return;

    setState(() {
      final top = initialTop;
      final left = (stackSize.width / 2) - (widgetSize.width / 2);
      widgetLocalOffset = Offset(left, top);
      animatesWidget = withAnimation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Translate onPan'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                key: stackKey,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.green,
                  ),
                  MovablePositioned(
                    key: widgetKey,
                    top: widgetLocalOffset.dy,
                    left: widgetLocalOffset.dx,
                    animates: animatesWidget,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _repositionWidget,
              child: const Text('Reset position'),
            ),
            ElevatedButton(
              onPressed: () {
                final left = (widgetKey.currentState as MovablePositionedState).left;
                final top = (widgetKey.currentState as MovablePositionedState).top;
                final widgetSize = getSizeFromKey(widgetKey);
                setState(() {
                  this.widgetLocalOffset = Offset(left, top);
                  this.widgetSize = widgetSize;
                });
              },
              child: const Text('Get widget position and size'),
            ),
            Text(
              'Widget position top: ${widgetLocalOffset.dy.round()}/ left: ${widgetLocalOffset.dx.round()}',
            ),
            Text(
              'Widget width: ${widgetSize?.width}/ height: ${widgetSize?.height}',
            ),
          ],
        ),
      ),
    );
  }
}

typedef OnPositionChanged = void Function(double, double);

class MovablePositioned extends StatefulWidget {
  const MovablePositioned({
    super.key,
    required this.top,
    required this.left,
    this.onPositionChanged,
    required this.animates,
  });

  final double top;
  final double left;
  final OnPositionChanged? onPositionChanged;
  final bool animates;

  @override
  State<MovablePositioned> createState() => MovablePositionedState();
}

class MovablePositionedState extends State<MovablePositioned> {
  late double left = widget.left;
  late double top = widget.top;
  bool animates = false;
  static const animationDurationMs = 300;

  @override
  void didUpdateWidget(covariant MovablePositioned oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Animation should not be permanent otherwise moving this widget on pan will be animated 
    if (widget.animates != animates) {
      animates = widget.animates;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        animates = false;
      });
    }

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
    print('top:$top / left:$left, animates:$animates');
    return AnimatedPositioned(
      top: top,
      left: left,
      duration: Duration(milliseconds: animates ? animationDurationMs : 0),
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            top = top + details.delta.dy;
            left = left + details.delta.dx;
          });
          widget.onPositionChanged?.call(top, left);
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
