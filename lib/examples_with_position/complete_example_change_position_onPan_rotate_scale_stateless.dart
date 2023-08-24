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
  static const double initialTop = 200;
  static const double initialScale = 1;
  static const double initialRotation = 0;

  final widgetKey = GlobalKey();
  final stackKey = GlobalKey();

  late Offset widgetLocalOffset = Offset(0, initialTop);
  // late double widgetRotation = initialRotation;
  // late double widgetScale = initialScale;

  WidgetInformation? widgetInfo;
  bool animatesWidget = true;

  // State for movable widget
  double left = 0;
  double top = initialTop;
  double rotation = initialRotation;
  // double previousRotation = initialRotation;
  double scale = initialScale;
  // double previousScale = initialScale;
  // End State for movable widget

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
      left = (stackSize.width / 2) - (widgetSize.width / 2);

      widgetLocalOffset = Offset(left, top);
      animatesWidget = withAnimation;
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
                    MovablePositioned(
                      key: widgetKey,
                      top: top,
                      left: left,
                      rotation: rotation,
                      scale: scale,
                      animates: animatesWidget,
                      onPositionChanged: (left, top) {
                        // widgetLocalOffset = Offset(left, top);
                      },
                      onRotationChanged: (double value) {},
                      onScaleChanged: (double value) {},
                      onUpdate: (double left, double top, double rotation, double scale) {
                        setState(() {
                          this.left = left;
                          this.top = top;
                          this.rotation = rotation;
                          this.scale = scale;
                        });
                      },
                      onScaleStart: (ScaleStartDetails details) {
                        // setState(() {
                        // previousRotation = rotation;
                        // previousScale = scale;
                        // });
                      },
                      // previousRotation: previousRotation,
                      // previousScale: previousScale,
                    ),
                  ],
                ),
              ),
            ),
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
                  position: Offset(left, top),
                  rotation: rotation,
                  scale: scale,
                );

                setState(() => this.widgetInfo = widgetInfo);
              },
              child: const Text('Get widget position and size'),
            ),
            if (widgetInfo != null)
              Text(
                '''Widget position top:${widgetInfo.position.dy.round()}
                Widget position left:${widgetInfo.position.dx.round()}
                Widget width: ${widgetInfo.size.width}/ height: ${widgetInfo.size.height}
                Widget rotation:${widgetInfo.rotation}
                Widget scale:${widgetInfo.scale}
              ''',
              )
            else
              Text('No widget info requested'),
            Text(
              'Widget position top: ${widgetLocalOffset.dy.round()}/ left: ${widgetLocalOffset.dx.round()}',
            ),
          ],
        ),
      ),
    );
  }
}

typedef OnPositionChanged = void Function(double left, double top);
typedef OnUpdate = void Function(double left, double top, double rotation, double scale);

class MovablePositioned extends StatefulWidget {
  const MovablePositioned({
    super.key,
    required this.top,
    required this.left,
    required this.onPositionChanged,
    required this.onRotationChanged,
    required this.onScaleChanged,
    required this.animates,
    this.rotation = 0,
    this.scale = 1,
    required this.onUpdate,
    required this.onScaleStart,
    this.previousRotation,
    this.previousScale,
  });

  final double top;
  final double left;
  final double rotation;
  final double? previousRotation;
  final double? previousScale;
  final double scale;
  final OnUpdate onUpdate;
  final OnPositionChanged onPositionChanged;
  final ValueChanged<double> onRotationChanged;
  final ValueChanged<double> onScaleChanged;
  final GestureScaleStartCallback onScaleStart;
  final bool animates;

  @override
  State<MovablePositioned> createState() => _MovablePositionedState();
}

class _MovablePositionedState extends State<MovablePositioned> {
  late double previousRotation = widget.rotation;
  late double previousScale = widget.scale;

  @override
  void didUpdateWidget(covariant MovablePositioned oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.rotation != previousRotation) {
      previousRotation = widget.rotation;
    }

    if (widget.scale != previousScale) {
      previousScale = widget.scale;
    }

    // Animation should not be permanent otherwise moving this widget on pan will be animated
    // if (widget.animates != animates) {
    //   animates = widget.animates;
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     animates = false;
    //   });
    // }

    // Parent wants to override this widget position
    // if (widget.top != top || widget.left != left) {
    //   left = widget.left * scale;
    //   top = widget.top * scale;
    // }

    // if (widget.rotation != rotation) {
    //   rotation = widget.rotation;
    // }

    // if (widget.scale != scale) {
    //   scale = widget.scale;
    // }
  }

  @override
  Widget build(BuildContext context) {
    print('F1 top:${widget.top.round()} / left:${widget.left.round()} / rotation:${widget.rotation} / scale:${widget.scale}');
    print('F1 previousRotation:$previousRotation / previousScale:$previousScale');
    return Positioned(
      top: widget.top,
      left: widget.left,
      child: Transform(
        transform: Matrix4.identity()
          ..rotateZ(widget.rotation)
          ..scale(widget.scale),
        alignment: FractionalOffset.center,
        child: GestureDetector(
          // onScaleStart: widget.onScaleStart,
          onScaleStart: (details) {
            previousRotation = widget.rotation;
            previousScale = widget.scale;
          },
          onScaleUpdate: (details) {
            final rotation = previousRotation + details.rotation;
            final scale = previousScale * details.scale;

            // Calculer le déplacement ajusté en fonction de la rotation et de l'échelle
            final adjustedDx = details.focalPointDelta.dx * scale;
            final adjustedDy = details.focalPointDelta.dy * scale;

            // Appliquer la rotation au déplacement ajusté
            final rotatedDx = adjustedDx * cos(rotation) - adjustedDy * sin(rotation);
            final rotatedDy = adjustedDy * cos(rotation) + adjustedDx * sin(rotation);

            final top = this.widget.top + rotatedDy;
            final left = this.widget.left + rotatedDx;

            widget.onUpdate(left, top, rotation, scale);
          },
          child: Container(
            color: Colors.black,
            height: 200.0,
            width: 200.0,
            child: Center(child: Text('👍', style: TextStyle(fontSize: 64))),
          ),
        ),
      ),
    );
  }
}
