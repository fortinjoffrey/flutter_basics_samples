import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MagnetismDemoUsingDelta extends StatefulWidget {
  const MagnetismDemoUsingDelta({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MagnetismDemoUsingDeltaState createState() => _MagnetismDemoUsingDeltaState();
}

class _MagnetismDemoUsingDeltaState extends State<MagnetismDemoUsingDelta> {
  final widgetKey = GlobalKey();
  static const double distanceThreshold = 2;
  static const double unsnapThreshold = 20;
  static const double deltaToSnapTheshold = 1;
  double widgetLeft = 0;
  double widgetTop = 0;
  bool verticallySnapped = false;
  bool horizontallySnapped = false;
  Offset fingerPosition = Offset.zero;
  Offset lastSnappedFingerPosition = Offset.zero;
  late double stackHeight;
  late double stackWidth;
  bool canShowVerticalLine = false;
  bool canShowHorizontalLine = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Magnetism Effect'),
      ),
      body: Listener(
        onPointerMove: (event) {
          fingerPosition = event.position;

          final dyDiff = (fingerPosition.dy - lastSnappedFingerPosition.dy);
          final dxDiff = (fingerPosition.dx - lastSnappedFingerPosition.dx);

          if (verticallySnapped && dyDiff.abs() > unsnapThreshold) {
            setState(() {
              verticallySnapped = false;
              widgetTop = dyDiff > 0 ? widgetTop + distanceThreshold : widgetTop - distanceThreshold;
            });
          }
          if (horizontallySnapped && dxDiff.abs() > unsnapThreshold) {
            setState(() {
              horizontallySnapped = false;
              widgetLeft = dxDiff > 0 ? widgetLeft + distanceThreshold : widgetLeft - distanceThreshold;
            });
          }
        },
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.grey,
                child: LayoutBuilder(builder: (context, constraints) {
                  stackHeight = constraints.maxHeight;
                  stackWidth = constraints.maxWidth;

                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      Positioned(
                        left: widgetLeft,
                        top: widgetTop,
                        child: GestureDetector(
                          onTap: () {},
                          onPanStart: (details) {
                            setState(() {
                              canShowHorizontalLine = true;
                              canShowVerticalLine = true;
                            });
                          },
                          onPanEnd: (details) {
                            setState(() {
                              canShowHorizontalLine = false;
                              canShowVerticalLine = false;
                            });
                          },
                          onPanUpdate: (details) {
                            if (verticallySnapped && horizontallySnapped) return;

                            setState(() {
                              if (!verticallySnapped) {
                                widgetTop += details.delta.dy;
                              }
                              if (!horizontallySnapped) {
                                widgetLeft += details.delta.dx;
                              }

                              checkForSnap(
                                height: constraints.maxHeight,
                                width: constraints.maxWidth,
                                deltaDy: details.delta.dy,
                                deltaDx: details.delta.dx,
                                widgetKey: widgetKey,
                              );
                            });
                          },
                          child: Container(
                            key: widgetKey,
                            width: 75,
                            height: 75,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 2,
                            height: 20,
                            color: Colors.red,
                          )),
                      Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 20,
                            height: 2,
                            color: Colors.red,
                          )),
                      if (verticallySnapped && canShowVerticalLine)
                        Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 1,
                              color: Colors.green,
                            )),
                      if (horizontallySnapped && canShowHorizontalLine)
                        Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 1,
                              height: MediaQuery.of(context).size.height,
                              color: Colors.green,
                            ))
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // get widget size from key
  Size? getSizeFromKey(GlobalKey key) {
    final RenderBox? renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    return renderBox?.size;
  }

  void checkForSnap({
    required double height,
    required double width,
    required double deltaDy,
    required double deltaDx,
    required GlobalKey widgetKey,
  }) {
    final widgetSize = getSizeFromKey(widgetKey);
    if (widgetSize == null) return;

    final widgetCenterDy = widgetTop + widgetSize.height / 2;
    final widgetCenterDx = widgetLeft + widgetSize.width / 2;
    final widgetCenter = Offset(widgetCenterDx, widgetCenterDy);
    final center = Offset(width / 2, height / 2);
    final verticalDistance = (widgetCenter - center).dy.abs();
    final horizontalDistance = (widgetCenter - center).dx.abs();

    if (!verticallySnapped && verticalDistance < distanceThreshold && deltaDy.abs() < deltaToSnapTheshold) {
      setState(() {
        widgetTop = center.dy - widgetSize.height / 2;

        HapticFeedback.mediumImpact();
        verticallySnapped = true;
        lastSnappedFingerPosition = Offset(lastSnappedFingerPosition.dx, fingerPosition.dy);
      });
    }

    if (!horizontallySnapped && horizontalDistance < distanceThreshold && deltaDx.abs() < deltaToSnapTheshold) {
      setState(() {
        widgetLeft = center.dx - widgetSize.width / 2;
        HapticFeedback.mediumImpact();
        horizontallySnapped = true;
        lastSnappedFingerPosition = Offset(fingerPosition.dx, lastSnappedFingerPosition.dy);
      });
    }
  }
}
