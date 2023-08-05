import 'package:flutter/material.dart';
import 'package:quiver/core.dart';

enum SelectableDraggableWidgetType { text, icon }

class _SelectableDraggableText extends StatelessWidget {
  const _SelectableDraggableText({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title);
  }
}

class SelectableDraggableWidget extends StatelessWidget {
  const SelectableDraggableWidget({
    super.key,
    required this.id,
    required this.onTap,
    required this.onDragEnd,
    required this.onDragStarted,
    required this.top,
    required this.left,
    required this.isSelected,
    required this.child,
    required this.onTapOutside,
    required this.type,
  });

  String? get title {
    final child = this.child;
    return child is _SelectableDraggableText ? child.title : null;
  }

  SelectableDraggableWidget copyWith({
    Optional<Key?>? key,
    double? top,
    double? left,
    bool? isSelected,
    String? title,
  }) {
    final getChild = () {
      if (title != null && type == SelectableDraggableWidgetType.text) {
        return _SelectableDraggableText(title: title);
      }
      return child;
    };

    return SelectableDraggableWidget(
      key: key != null ? key.orNull : this.key,
      id: id,
      onTap: onTap,
      onDragEnd: onDragEnd,
      onDragStarted: onDragStarted,
      top: top ?? this.top,
      left: left ?? this.left,
      isSelected: isSelected ?? this.isSelected,
      child: getChild(),
      onTapOutside: onTapOutside,
      type: type,
    );
  }

  SelectableDraggableWidget.text({
    super.key,
    required String title,
    required this.id,
    required this.onTap,
    required this.onDragEnd,
    required this.onDragStarted,
    required this.top,
    required this.left,
    required this.isSelected,
    required this.onTapOutside,
  })  : child = _SelectableDraggableText(title: title),
        type = SelectableDraggableWidgetType.text;

  SelectableDraggableWidget.icon({
    super.key,
    required IconData iconData,
    required this.id,
    required this.onTap,
    required this.onDragEnd,
    required this.onDragStarted,
    required this.top,
    required this.left,
    required this.isSelected,
    required this.onTapOutside,
  })  : child = Icon(iconData, color: Colors.red),
        type = SelectableDraggableWidgetType.icon;

  final String id;
  final GestureTapCallback onTap;
  final ValueChanged<Offset> onTapOutside;
  // final DragEndCallback onDragEnd;
  final VoidCallback onDragStarted;
  final void Function(DraggableDetails details, String id) onDragEnd;
  final double? top;
  final double? left;
  final bool isSelected;
  final Widget child;
  final SelectableDraggableWidgetType type;

  @override
  Widget build(BuildContext context) {
    final Widget wrappedChild = Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
        child: child,
      ),
    );

    return Positioned(
      top: top,
      left: left,
      child: GestureDetector(
        onTap: () {
          print('tap');
          if (isSelected) return;
          onTap();
        },
        child: Draggable(
          data: id,
          childWhenDragging: const SizedBox.shrink(),
          onDragStarted: () {
            onDragStarted();
          },
          onDragEnd: (details) {
            onDragEnd(details, id);
          },
          feedback: Material(color: Colors.transparent, child: wrappedChild),
          child: TapRegion(
            onTapOutside: (PointerDownEvent event) {
              if (isSelected) {
                onTapOutside(event.position);
              }
            },
            // onTapInside: (event) {
            //   if (isSelected) return;
            //   onTap();
            // },
            child: wrappedChild,
          ),
        ),
      ),
    );
  }
}

extension DraggrableWidgetsExtension on List<SelectableDraggableWidget> {
  bool get isTextSelected {
    final selectedWidgetIndex =
        this.indexWhere((widget) => widget.isSelected && widget.type == SelectableDraggableWidgetType.text);
    return selectedWidgetIndex != -1;
  }

  bool get hasWidgetSelected {
    final selectedWidgetIndex = this.indexWhere((widget) => widget.isSelected);
    return selectedWidgetIndex != -1;
  }
}
