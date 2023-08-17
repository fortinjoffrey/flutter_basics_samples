import 'package:basics_samples/matrix_gesture_detector/matrix_gesture_detector_modified.dart';
import 'package:flutter/material.dart';

typedef PointerMoveCallback = void Function(Offset offset, Key? key);

class OverlayWidget extends StatelessWidget {
  const OverlayWidget({
    super.key,
    required this.child,
    required this.onDragStart,
    required this.onDragEnd,
    required this.onDragUpdate,
  });

  final Widget child;
  final VoidCallback onDragStart;
  final PointerMoveCallback onDragEnd;
  final PointerMoveCallback onDragUpdate;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<Matrix4> notifier = ValueNotifier(Matrix4.identity());
    late Offset offset;

    return Listener(
      onPointerMove: (event) {
        offset = event.position;
        onDragUpdate(offset, key);
      },
      child: MatrixGestureDetector(
        onMatrixUpdate: (matrix, translationDeltaMatrix, scaleDeltaMatrix, rotationDeltaMatrix) {
          notifier.value = matrix;
        },
        child: AnimatedBuilder(
          animation: notifier,
          builder: (context, childWidget) {
            return Transform(
              transform: notifier.value,
              child: Align(
                alignment: Alignment.center,
                // child: child,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: child,
                ),
              ),
            );
          },
        ),
        onScaleStart: onDragStart,
        onScaleEnd: () => onDragEnd(offset, key),
      ),
    );
  }
}
