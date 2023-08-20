import 'package:flutter/material.dart';

Size? getSizeFromKey(GlobalKey key) {
  return key.currentContext?.size;
}

Offset? getGlobalOffset({required GlobalKey key}) {
  final keyContext = key.currentContext;
  final size = keyContext?.size;
  if (keyContext == null || size == null) return null;

  final renderBox = keyContext.findRenderObject() as RenderBox;

  final globalOffset = renderBox.localToGlobal(Offset.zero);

  return globalOffset;
}

Offset? getLocalOffsetInAncestor({
  required GlobalKey childKey,
  required GlobalKey ancestorKey,
}) {
  final keyContext = childKey.currentContext;
  final size = keyContext?.size;
  if (keyContext == null || size == null) return null;

  final renderBox = keyContext.findRenderObject() as RenderBox;

  final parentContext = ancestorKey.currentContext;
  final parentSize = parentContext?.size;
  if (parentContext == null || parentSize == null) return null;

  final parentRenderBox = parentContext.findRenderObject() as RenderBox;

  final childGlobalOffset = renderBox.localToGlobal(Offset.zero);
  final childLocalOffset = parentRenderBox.globalToLocal(childGlobalOffset);
  return childLocalOffset;
}

bool isOffsetOnElement({
  required Offset offset,
  required Size elementSize,
  required Offset elementPosition,
  double tolerance = 0,
}) {
  final isXIn =
      elementPosition.dx - tolerance <= offset.dx && offset.dx <= elementPosition.dx + elementSize.width + tolerance;
  final isYIn =
      elementPosition.dy - tolerance <= offset.dy && offset.dy <= elementPosition.dy + elementSize.height + tolerance;
  return isXIn && isYIn;
}
