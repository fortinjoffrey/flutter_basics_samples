import 'package:flutter/material.dart';
import 'package:quiver/core.dart';

enum SelectableDraggableWidgetType { text, icon }

class _SelectableDraggableText extends StatelessWidget {
  const _SelectableDraggableText({
    required this.title,
    this.fontSize,
    this.color,
  });

  final String title;
  final double? fontSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
      ),
    );
  }

  _SelectableDraggableText copyWith({
    Optional<double?>? fontSize,
    Optional<Color?>? fontColor,
    Optional<String>? title,
  }) {
    return _SelectableDraggableText(
      title: title != null ? title.value : this.title,
      color: fontColor != null ? fontColor.orNull : this.color,
      fontSize: fontSize != null ? fontSize.orNull : this.fontSize,
    );
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
    this.isDragged = false,
  });

  String? get title {
    final child = this.child;
    return child is _SelectableDraggableText ? child.title : null;
  }

  SelectableDraggableWidget copyWith({
    Optional<Key?>? key,
    Optional<double?>? top,
    Optional<double?>? left,
    Optional<double?>? fontSize,
    Optional<Color?>? fontColor,
    bool? isSelected,
    bool? isDragged,
    Optional<String>? title,
  }) {
    final getChild = () {
      if (type == SelectableDraggableWidgetType.text && (fontSize != null || fontColor != null || title != null)) {
        final widget = child as _SelectableDraggableText;
        return widget.copyWith(
          title: title,
          fontColor: fontColor,
          fontSize: fontSize,
        );
      }
      return child;
    };

    return SelectableDraggableWidget(
      key: key != null ? key.orNull : this.key,
      id: id,
      onTap: onTap,
      onDragEnd: onDragEnd,
      onDragStarted: onDragStarted,
      top: top != null ? top.orNull : this.top,
      left: left != null ? left.orNull : this.left,
      isSelected: isSelected ?? this.isSelected,
      isDragged: isDragged ?? false,
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
    this.isDragged = false,
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
    this.isDragged = false,
  })  : child = Icon(iconData, color: Colors.red),
        type = SelectableDraggableWidgetType.icon;

  final String id;
  final GestureTapCallback onTap;
  final ValueChanged<Offset> onTapOutside;
  final DragEndCallback onDragEnd;
  final VoidCallback onDragStarted;
  final double? top;
  final double? left;
  final bool isSelected;
  final bool isDragged;
  final Widget child;
  final SelectableDraggableWidgetType type;

  @override
  Widget build(BuildContext context) {
    print('isSelected: $isSelected');
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

    print('isDraged: $isDragged');

    return AnimatedPositioned(
      top: top,
      curve: Curves.easeInOut,
      left: left,
      duration: Duration(milliseconds: !isDragged ? 500 : 0),
      child: GestureDetector(
        onTap: () {
          if (isSelected) return;
          onTap();
        },
        child: Draggable(
          data: id,
          childWhenDragging: const SizedBox.shrink(),
          onDragStarted: () {
            onDragStarted();
          },
          onDragEnd: onDragEnd,
          feedback: Material(color: Colors.transparent, child: wrappedChild),
          child: TapRegion(
            onTapOutside: (PointerDownEvent event) {
              if (isSelected) {
                onTapOutside(event.position);
              }
            },
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

extension SelectableDraggableWidgetX on SelectableDraggableWidget {
  bool get isText => this.child is _SelectableDraggableText;
}
