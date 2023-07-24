import 'package:flutter/material.dart';

class DraggableText extends SelectableDraggableWidget {
  DraggableText({
    required super.id,
    required super.onTap,
    required super.onDragEnd,
    required super.top,
    required super.left,
    required super.isSelected,
  }) : super(child: Text('Drag me too'));
}

class DraggableIcon extends SelectableDraggableWidget {
  DraggableIcon({
    required super.id,
    required super.onTap,
    required super.onDragEnd,
    required super.top,
    required super.left,
    required super.isSelected,
  }) : super(child: Icon(Icons.hardware));
}

class SelectableDraggableWidget extends StatelessWidget {
  const SelectableDraggableWidget({
    super.key,
    required this.id,
    required this.onTap,
    required this.onDragEnd,
    required this.top,
    required this.left,
    required this.isSelected,
    required this.child,
  });

  final String id;
  final GestureTapCallback onTap;
  final DragEndCallback onDragEnd;
  final double? top;
  final double? left;
  final bool isSelected;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final Widget wrappedChild = Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.transparent,
        ),
      ),
      child: child,
    );

    return Positioned(
      top: top,
      left: left,
      child: TapRegion(
        onTap: onTap,
        child: isSelected
            ? Draggable(
                data: id,
                childWhenDragging: const SizedBox.shrink(),
                onDragStarted: () {},
                onDragEnd: onDragEnd,
                feedback: Material(color: Colors.transparent, child: wrappedChild),
                child: wrappedChild)
            : wrappedChild,
      ),
    );
    // return Positioned(
    //   top: top,
    //   left: left,
    //   child: GestureDetector(
    //     onTap: onTap,
    //     child: isSelected
    //         ? Draggable(
    //             data: id,
    //             childWhenDragging: const SizedBox.shrink(),
    //             onDragStarted: () {},
    //             onDragEnd: onDragEnd,
    //             feedback: Material(color: Colors.transparent, child: wrappedChild),
    //             child: wrappedChild)
    //         : wrappedChild,
    //   ),
    // );
  }
}
