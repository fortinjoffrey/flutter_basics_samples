import 'dart:math';

import 'package:basics_samples/complete_example_with_gesture_detector/mutiple_movable_cubit/multiple_movable_cubit.dart';
import 'package:basics_samples/complete_example_with_gesture_detector/mutiple_movable_cubit/multiple_movable_state.dart';
import 'package:basics_samples/utils/offset_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

class CompleteChangePositionMultipleOnPanRotateScaleStateless extends StatefulWidget {
  @override
  _ExampleChangePositionOnPanState createState() => _ExampleChangePositionOnPanState();
}

class _ExampleChangePositionOnPanState extends State<CompleteChangePositionMultipleOnPanRotateScaleStateless> {
  static const double initialTop = 100;
  static const double initialScale = 1;
  static const double initialRotation = pi / 4;
  final double? initialLeft = null;

  final stackKey = GlobalKey();
  final bottomSectionKey = GlobalKey();

  // WidgetInformation? widgetInfo;
  bool animatesWidget = false;

  @override
  void initState() {
    super.initState();

    // if (initialLeft == null)
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _repositionWidget(withAnimation: false);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multiple movable widgets'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                child: BlocConsumer<MultipleMovableCubit, MultipleMovableState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return Stack(
                      key: stackKey,
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.green,
                        ),
                        ...state.movablePositionedStates
                            .map((st) {
                              return MovablePositionedStateless(
                                key: st.key,
                                top: st.top,
                                left: st.left,
                                rotation: st.rotation,
                                scale: st.scale,
                                animates: st.animates,
                                previousRotation: st.previousRotation,
                                previousScale: st.previousScale,
                                onScaleStart: (_) {
                                  context.read<MultipleMovableCubit>().onScaleStart(st.key);
                                },
                                onUpdate: (double left, double top, double rotation, double scale) {
                                  context.read<MultipleMovableCubit>().onUpdate(
                                        key: st.key,
                                        scale: scale,
                                        rotation: rotation,
                                        top: top,
                                        left: left,
                                      );
                                },
                                onTap: () {
                                  context.read<MultipleMovableCubit>().onTap(
                                        key: st.key,
                                        stackKey: stackKey,
                                      );
                                },
                                selected: st.selected,
                                onTapOutside: (Offset value) {
                                  context.read<MultipleMovableCubit>().onTapOutside(
                                        tapPosition: value,
                                        stackKey: stackKey,
                                        bottomSectionKey: bottomSectionKey,
                                      );
                                },
                              );
                            })
                            .toList()
                            .withOpacity(),
                      ],
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              key: bottomSectionKey,
              height: 180,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => context.read<MultipleMovableCubit>().createMovablePositioned(),
                        child: const Text('New widget'),
                      ),
                      BlocBuilder<MultipleMovableCubit, MultipleMovableState>(builder: (context, state) {
                        return Column(
                            children: state.movablePositionedStates
                                .map((MovablePositionedState e) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(e.toString()),
                                    ))
                                .toList());
                      }),
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
    required this.onTap,
    required this.selected,
    required this.onTapOutside,
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
  final GestureTapCallback onTap;
  final bool selected;
  final ValueChanged<Offset> onTapOutside;

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
        child: TapRegion(
          onTapOutside: (event) {
            if (selected) {
              onTapOutside(event.position);
            }
          },
          child: Builder(builder: (context) {
            return GestureDetector(
              onTap: onTap,
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
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(color: selected ? Colors.blue : Colors.transparent),
                  borderRadius: BorderRadius.circular(8),
                ),
                // height: 200.0,
                // width: 200.0,/
                child: Center(child: Text('👍', style: TextStyle(fontSize: 64))),
              ),
            );
          }),
        ),
      ),
    );
  }
}

extension MovablePositionedExtension on List<MovablePositionedStateless> {
  bool get hasWidgetSelected {
    final selectedWidgetIndex = indexWhere((widget) => widget.selected);
    return selectedWidgetIndex != -1;
  }

  List<Widget> withOpacity() {
    return [
      if (length > 1) ...getRange(0, length - 1),
      Positioned.fill(
        child: IgnorePointer(
          ignoring: !hasWidgetSelected,
          child: AnimatedOpacity(
            opacity: hasWidgetSelected ? .4 : 0,
            duration: const Duration(seconds: 1),
            child: Container(color: Colors.black),
          ),
        ),
      ),
      if (isNotEmpty) last,
    ];
  }
}
