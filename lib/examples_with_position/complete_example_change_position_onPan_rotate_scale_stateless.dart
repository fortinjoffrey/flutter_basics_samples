import 'dart:math';

import 'package:basics_samples/utils/offset_utils.dart';
import 'package:flutter/material.dart';

class WidgetInformation {
  final Size size;
  final Offset position;
  final double rotation;
  final double scale;

  const WidgetInformation({
    required this.size,
    required this.position,
    required this.rotation,
    required this.scale,
  });
}

class CompleteChangePositionOnPanRotateScaleStateless extends StatefulWidget {
  @override
  _ExampleChangePositionOnPanState createState() => _ExampleChangePositionOnPanState();
}

class _ExampleChangePositionOnPanState extends State<CompleteChangePositionOnPanRotateScaleStateless> {
  static const double initialTop = 50;
  static const double initialScale = 0.898;
  static const double initialRotation = -19.6;
  final double? initialLeft = 164;
  // static const double initialTop = 200;
  // static const double initialScale = 1;
  // static const double initialRotation = 0;

  final widgetKey = GlobalKey();
  final stackKey = GlobalKey();

  late Offset widgetLocalOffset = Offset(initialLeft ?? 0, initialTop);
  late double widgetRotation = initialRotation;
  late double widgetPreviousRotation = initialRotation;
  late double widgetScale = initialScale;
  late double widgetPreviousScale = initialScale;

  WidgetInformation? widgetInfo;
  bool animatesWidget = false;

  @override
  void initState() {
    super.initState();

    if (initialLeft == null)
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
      widgetRotation = initialRotation;
      widgetPreviousRotation = widgetRotation;
      widgetScale = initialScale;
      widgetPreviousScale = widgetScale;
      animatesWidget = withAnimation;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        animatesWidget = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final widgetInfo = this.widgetInfo;

    return Scaffold(
      appBar: AppBar(
        title: Text('CompleteChangePositionOnPanRotateScaleStateless'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                child: Stack(
                  key: stackKey,
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.green,
                    ),
                    MovablePositionedStateless(
                      key: widgetKey,
                      top: widgetLocalOffset.dy,
                      left: widgetLocalOffset.dx,
                      rotation: widgetRotation,
                      scale: widgetScale,
                      animates: animatesWidget,
                      previousRotation: widgetPreviousRotation,
                      previousScale: widgetPreviousScale,
                      onScaleStart: (ScaleStartDetails details) {
                        setState(() {
                          widgetPreviousRotation = widgetRotation;
                          widgetPreviousScale = widgetScale;
                        });
                      },
                      onUpdate: (double left, double top, double rotation, double scale) {
                        setState(() {
                          widgetLocalOffset = Offset(left, top);
                          widgetRotation = rotation;
                          widgetScale = scale;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 180,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _repositionWidget,
                        child: const Text('Reset position'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final widgetSize = getSizeFromKey(widgetKey);

                          if (widgetSize == null) return;

                          final widgetInfo = WidgetInformation(
                            size: widgetSize,
                            position: widgetLocalOffset,
                            rotation: widgetRotation,
                            scale: widgetScale,
                          );

                          setState(() => this.widgetInfo = widgetInfo);
                        },
                        child: const Text('Get widget position and size'),
                      ),
                      if (widgetInfo != null) ...[
                        Text('top:${widgetInfo.position.dy.round()} / left:${widgetInfo.position.dx.round()} '),
                        Text('width: ${widgetInfo.size.width.round()} / height: ${widgetInfo.size.height.round()}'),
                        Text('rotation:${widgetInfo.rotation}'),
                        Text('scale:${widgetInfo.scale}'),
                      ] else
                        Text('No widget info requested'),
                    ],
                  ),
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
typedef OnUpdate = void Function(double left, double top, double rotation, double scale);

class MovablePositionedStateless extends StatelessWidget {
  const MovablePositionedStateless({
    GlobalKey? key,
    required this.top,
    required this.left,
    required this.animates,
    this.rotation = 0,
    this.scale = 1,
    required this.onUpdate,
    required this.onScaleStart,
    required this.previousRotation,
    required this.previousScale,
  }) : super(key: key);

  final double top;
  final double? left;
  final double rotation;
  final double previousRotation;
  final OnUpdate onUpdate;
  final double scale;
  final double previousScale;
  final bool animates;
  final GestureScaleStartCallback onScaleStart;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      top: top,
      left: left,
      duration: Duration(milliseconds: animates ? 300 : 0),
      child: Transform(
        transform: Matrix4.identity()
          ..rotateZ(rotation)
          ..scale(scale),
        alignment: FractionalOffset.center,
        child: Builder(builder: (context) {
          return GestureDetector(
            onScaleStart: onScaleStart,
            onScaleUpdate: (details) {
              final rotation = previousRotation + details.rotation;
              final scale = previousScale * details.scale;

              final adjustedDx = details.focalPointDelta.dx * scale;
              final adjustedDy = details.focalPointDelta.dy * scale;

              final rotatedDx = adjustedDx * cos(rotation) - adjustedDy * sin(rotation);
              final rotatedDy = adjustedDy * cos(rotation) + adjustedDx * sin(rotation);

              final top = this.top + rotatedDy;
              double left;

              if (this.left == null) {
                final widgetKey = key as GlobalKey?;
                Size? widgetSize = const Size(0, 0);
                if (widgetKey != null) {
                  widgetSize = getSizeFromKey(key as GlobalKey);
                }

                left =
                    (this.left ?? (MediaQuery.of(context).size.width / 2) - (widgetSize?.width ?? 0) / 2) + rotatedDx;
              } else {
                left = this.left! + rotatedDx;
              }

              onUpdate(left, top, rotation, scale);
            },
            child: Container(
              color: Colors.black,
              height: 200.0,
              width: 200.0,
              child: Center(child: Text('👍', style: TextStyle(fontSize: 64))),
            ),
          );
        }),
      ),
    );
  }
}
