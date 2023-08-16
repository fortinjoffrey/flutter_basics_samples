import 'package:flutter/material.dart';
import 'package:quiver/core.dart';

enum SelectableDraggableWidgetType { text, icon }

class _SelectableDraggableText extends StatelessWidget {
  const _SelectableDraggableText({
    required this.title,
    this.fontSize = 24,
    this.color = Colors.black,
  });

  final String title;
  final double? fontSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData(devicePixelRatio: 1),
      child: Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
        ),
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
  const SelectableDraggableWidget._({
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
    required this.maxWidth,
    this.isDragged = false,
  });

  static const double widthGap = 64;
  static const double horizontalPadding = 8;
  static const double verticalPadding = 2;
  static const double borderWidth = 1;

  String? get title {
    final child = this.child;
    return child is _SelectableDraggableText ? child.title : null;
  }

  double? get fontSize {
    final child = this.child;
    return child is _SelectableDraggableText ? child.fontSize : null;
  }

  Color? get color {
    final child = this.child;
    return child is _SelectableDraggableText ? child.color : null;
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

    return SelectableDraggableWidget._(
      key: key != null ? key.orNull : this.key,
      id: id,
      onTap: onTap,
      onDragEnd: onDragEnd,
      onDragStarted: onDragStarted,
      maxWidth: maxWidth,
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
    double? fontSize,
    Color? color,
    required this.id,
    required this.onTap,
    required this.onDragEnd,
    required this.onDragStarted,
    required this.top,
    required this.left,
    required this.isSelected,
    required this.onTapOutside,
    required this.maxWidth,
    this.isDragged = false,
  })  : child = _SelectableDraggableText(
          title: title,
          fontSize: fontSize,
          color: color,
        ),
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
    required this.maxWidth,
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
  final double maxWidth;
  final SelectableDraggableWidgetType type;

  @override
  Widget build(BuildContext context) {
    final Widget wrappedChild = ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: maxWidth - widthGap,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: borderWidth,
            color: isSelected ? Colors.blue : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
          child: child,
        ),
      ),
    );

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
