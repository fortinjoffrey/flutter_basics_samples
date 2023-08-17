import 'package:basics_samples/complete_example_using_matrix_gesture_detector/overlay_widget.dart';
import 'package:basics_samples/complete_example_using_matrix_gesture_detector/utils.dart';
import 'package:flutter/material.dart';

class CompleteExampleUsingMatrixGestureDetector extends StatefulWidget {
  const CompleteExampleUsingMatrixGestureDetector({super.key});

  @override
  State<CompleteExampleUsingMatrixGestureDetector> createState() => _CompleteExampleUsingMatrixGestureDetectorState();
}

class _CompleteExampleUsingMatrixGestureDetectorState extends State<CompleteExampleUsingMatrixGestureDetector> {
  List<Widget> widgets = [];

  bool isDragging = false;
  bool isDeleteButtonActive = false;
  final deleteIconKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('example_using_matrix_gesture_detector'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            color: Colors.yellow,
          ),
          ...widgets.map((e) => e),
          if (isDragging)
            Positioned(
              bottom: 50,
              child: CircleAvatar(
                key: deleteIconKey,
                backgroundColor: isDeleteButtonActive ? Colors.red : Colors.white,
                child: Icon(
                  Icons.delete,
                  size: 24,
                  color: isDeleteButtonActive ? Colors.white : Colors.black,
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (widgets.length < dummyWidgets.length) {
            setState(() {
              widgets.add(
                OverlayWidget(
                  key: Key(widgets.length.toString()),
                  onDragStart: () {
                    if (!isDragging) setState(() => isDragging = true);
                  },
                  onDragEnd: (offset, key) {
                    if (isDragging) setState(() => isDragging = false);

                    if (isOffsetOnDeleteIcon(offset)) {
                      setState(() {
                        widgets.removeWhere((widget) => widget.key == key);
                        isDeleteButtonActive = false;
                      });
                    }
                  },
                  onDragUpdate: (Offset offset, Key? key) {
                    final isPointerOnDelete = isOffsetOnDeleteIcon(offset);

                    if (isPointerOnDelete) setState(() => isDeleteButtonActive = true);
                    if (!isPointerOnDelete) setState(() => isDeleteButtonActive = false);
                  },
                  child: dummyWidgets.elementAt(widgets.length),
                ),
              );
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  bool isOffsetOnDeleteIcon(Offset offset) {
    final deleteIconPosition = getOffsetFromKey(deleteIconKey);
    final deleteIconSize = getSizeFromKey(deleteIconKey);

    if (deleteIconPosition == null || deleteIconSize == null) return false;

    return isOffsetOnElement(
      offset: offset,
      elementSize: deleteIconSize,
      elementPosition: deleteIconPosition,
      tolerance: 15,
    );
  }
}

final List<Widget> dummyWidgets = [
  Text('😄', style: TextStyle(fontSize: 120)),
  ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Container(
      color: Colors.black,
      padding: EdgeInsets.all(8),
      child: Text(
        'Hello world',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    ),
  ),
];
