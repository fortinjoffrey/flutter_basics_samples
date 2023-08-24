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

class CompleteChangePositionOnPanRotateScaleStateful extends StatefulWidget {
  @override
  _ExampleChangePositionOnPanState createState() => _ExampleChangePositionOnPanState();
}

class _ExampleChangePositionOnPanState extends State<CompleteChangePositionOnPanRotateScaleStateful> {
  static const double initialTop = 290;
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
  late double widgetScale = initialScale;

  WidgetInformation? widgetInfo;
  bool animatesWidget = true;

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
      widgetScale = initialScale;
      animatesWidget = withAnimation;
    });
  }

  @override
  Widget build(BuildContext context) {
    final widgetInfo = this.widgetInfo;

    return Scaffold(
      appBar: AppBar(
        title: Text('CompleteChangePositionOnPanRotateScaleStateful'),
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
                      top: widgetLocalOffset.dy,
                      left: widgetLocalOffset.dx,
                      rotation: widgetRotation,
                      scale: widgetScale,
                      animates: animatesWidget,
                      onUpdate: (double left, double top, double rotation, double scale) {
                        // no need to setState
                        widgetLocalOffset = Offset(left, top);
                        widgetRotation = rotation;
                        widgetScale = scale;
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

class MovablePositioned extends StatefulWidget {
  const MovablePositioned({
    super.key,
    required this.top,
    required this.left,
    required this.animates,
    this.rotation = 0,
    this.scale = 1,
    required this.onUpdate,
  });

  final double top;
  final double left;
  final double rotation;
  final OnUpdate onUpdate;
  final double scale;
  final bool animates;

  @override
  State<MovablePositioned> createState() => MovablePositionedState();
}

class MovablePositionedState extends State<MovablePositioned> {
  bool animates = false;
  static const animationDurationMs = 300;
  late double left = widget.left;
  late double top = widget.top;
  late double rotation = widget.rotation;
  late double previousRotation = widget.rotation;
  late double scale = widget.scale;
  late double previousScale = widget.scale;

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
      left = widget.left;
      top = widget.top;
    }

    if (widget.rotation != rotation) {
      rotation = widget.rotation;
    }

    if (widget.scale != scale) {
      scale = widget.scale;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('S1 top:${top.round()} / left:${left.round()} / animates:$animates / rotation:$rotation / scale:$scale');
    return AnimatedPositioned(
      top: top,
      left: left,
      duration: Duration(milliseconds: animates ? animationDurationMs : 0),
      child: Transform(
        transform: Matrix4.identity()
          ..rotateZ(rotation)
          ..scale(scale),
        alignment: FractionalOffset.center,
        child: Builder(builder: (context) {
          return GestureDetector(
            onScaleStart: (details) {
              previousRotation = rotation;
              previousScale = scale;
            },
            onScaleUpdate: (details) {
              setState(() {
                rotation = previousRotation + details.rotation;
                scale = previousScale * details.scale;

                // Calculer le déplacement ajusté en fonction de la rotation et de l'échelle
                final adjustedDx = details.focalPointDelta.dx * scale;
                final adjustedDy = details.focalPointDelta.dy * scale;

                // Appliquer la rotation au déplacement ajusté
                final rotatedDx = adjustedDx * cos(rotation) - adjustedDy * sin(rotation);
                final rotatedDy = adjustedDy * cos(rotation) + adjustedDx * sin(rotation);

                top = top + rotatedDy;
                left = left + rotatedDx;

                widget.onUpdate(left, top, rotation, scale);
              });
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
