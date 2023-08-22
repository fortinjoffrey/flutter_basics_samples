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
  static const double initialTop = 200;
  static const double initialScale = 1;
  static const double initialRotation = 0;

  final widgetKey = GlobalKey();
  final stackKey = GlobalKey();

  late Offset widgetLocalOffset = Offset(0, initialTop);
  late double widgetRotation = initialRotation;
  late double widgetScale = initialScale;

  WidgetInformation? widgetInfo;
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
                      onPositionChanged: (left, top) {
                        widgetLocalOffset = Offset(left, top);
                      },
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
                final left = (widgetKey.currentState as MovablePositionedState).left;
                final top = (widgetKey.currentState as MovablePositionedState).top;
                final rotation = (widgetKey.currentState as MovablePositionedState).rotation;
                final scale = (widgetKey.currentState as MovablePositionedState).scale;
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

class MovablePositioned extends StatefulWidget {
  const MovablePositioned({
    super.key,
    required this.top,
    required this.left,
    this.onPositionChanged,
    required this.animates,
    this.rotation = 0,
    this.scale = 1,
  });

  final double top;
  final double left;
  final double rotation;
  final double scale;
  final OnPositionChanged? onPositionChanged;
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
  late double leadingCoefficient;
  late double originCoordinate;
  GlobalKey _key = GlobalKey();
  Size? _lastSize;

  @override
  void initState() {
    super.initState();
    // calculer la coordonnées à l'origine
    // originCoordinate = top - left * leadingCoefficient;
  }

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
      left = widget.left * scale;
      top = widget.top * scale;

      // originCoordinate = top - (left * leadingCoefficient);
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = getSizeFromKey(_key);
      if (size == null) return;
      _lastSize = size;
      // leadingCoefficient = -(size.width/2);
      // originCoordinate = this.top - (this.left * leadingCoefficient);
      print('size=$size');
      // print('leadingCoefficient=$leadingCoefficient');
      // print('originCoordinate=$originCoordinate');
      final newWidth = size.width * scale;
      final top = this.top - ((newWidth - size.width) / 2);
      final left = this.left - ((newWidth - size.width) / 2);
      // setState(() {
      //   this.top = top;
      //   this.left = left;
      // });
      print('top:$top');
      print('left:$left');
    });
    print('top:${top.round()} / left:${left.round()} / animates:$animates / rotation:$rotation / scale:$scale');
    return AnimatedPositioned(
      top: top,
      left: left,
      duration: Duration(milliseconds: animates ? animationDurationMs : 0),
      child: Transform(
        key: _key,
        transform: Matrix4.identity()..rotateZ(rotation),
        alignment: FractionalOffset.center,
        child: GestureDetector(
          onScaleStart: (details) {
            previousRotation = rotation;
            previousScale = scale;
          },
          onScaleUpdate: (details) {
            // if (previousScale != details.scale) {
            //   //
            //   top = (top * details.scale);
            //   left = (left * details.scale);
            // } else {
            //   top = top + details.focalPointDelta.dy;
            //   left = left + details.focalPointDelta.dx;
            // }

            // print()

            // top = top + (details.focalPointDelta.dy * sin( pi/2 - rotation));
            // left = left + (details.focalPointDelta.dx * cos(rotation));
            if (details.scale != scale || details.rotation != rotation) {
              final size = getSizeFromKey(_key);
              if (size == null) return;

              if (_lastSize != size) {
                print('D1 size=$size');
                final newWidth = size.width * details.scale;
                print('D1 newWidth=$newWidth');
                final top = this.top - ((newWidth - size.width) / 10);
                final left = this.left - ((newWidth - size.width) / 10);
                // final top = this.top - ((newWidth - size.width) / 2);
                // final left = this.left - ((newWidth - size.width) / 2);
                setState(() {
                  rotation = previousRotation + details.rotation;
                  scale = previousScale * details.scale;
                  this.top = top;
                  this.left = left;
                });
              }
            }
            // } else {
            //   setState(() {
            //     top = top + details.focalPointDelta.dy;
            //     left = left + details.focalPointDelta.dx;
            //   });
            //   widget.onPositionChanged?.call(left, top);
            // }

            // BEFORE
            // setState(() {
            //   rotation = previousRotation + details.rotation;
            //   scale = previousScale * details.scale;
            //   top = top + details.focalPointDelta.dy;
            //   left = left + details.focalPointDelta.dx;

            //   print('rotation: $rotation');
            //   print('details.focalPointDelta.dy:${details.focalPointDelta.dy}');
            //   print('details.focalPointDelta.dx:${details.focalPointDelta.dx}');

            //   widget.onPositionChanged?.call(left, top);
            // });
          },
          child: Container(
            color: Colors.black,
            height: 200.0 * scale,
            width: 200.0 * scale,
            child: Center(child: Text('👍', style: TextStyle(fontSize: 64))),
          ),
        ),
      ),
    );
  }
}

// En scalant déplacer en même

// Mettre un GestureDectector -> Transform 
//   si scale 1 = 200px/200px (h/w) Le GestureDector fera 200x200
//   si scale 2 = 400px/400px (h/w) Le GestureDector fera toujours 200x200
// PB de détection uniquement dans les dimensions initiales

// Mettre Transform -> GetureDetector
//   si scale 1 = 200px/200px (h/w) Le GestureDector fera 200x200
//   si scale 2 = 400px/400px (h/w) Le GestureDector fera 400x400
// PB lorsqu'on déplace le widgte vu que le GestureDector est "tordu" en cas de rotation 
//   alors on le déplace de façon tordu également 
// Hypothèse de solution:
//   quand on déplace en x, il faut déplacer en x et y en fonction de 
//      la rotation et du scale !
//   le plus dur: trouver la formule mathématique

// 


