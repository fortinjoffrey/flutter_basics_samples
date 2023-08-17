import 'package:flutter/material.dart';

Size? getSizeFromKey(GlobalKey key) {
  return key.currentContext?.size;
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

Offset? getOffsetFromKey(GlobalKey key) {
  final keyContext = key.currentContext;
  final stackSize = keyContext?.size;
  if (keyContext == null || stackSize == null) return null;

  final renderBox = keyContext.findRenderObject() as RenderBox;
  return renderBox.localToGlobal(Offset.zero);
}
