import 'package:flutter/material.dart';

Size? getSizeFromKey(GlobalKey key) {
  final RenderBox? renderBox = key.currentContext?.findRenderObject() as RenderBox?;
  return renderBox?.size;
}

Offset? getGlobalOffset({required GlobalKey key}) {
  final RenderBox? renderBox = key.currentContext?.findRenderObject() as RenderBox?;
  return renderBox?.localToGlobal(Offset.zero);
}

Offset? getLocalOffsetInAncestor({
  required GlobalKey childKey,
  required GlobalKey ancestorKey,
}) {
  final RenderBox? childRenderBox = childKey.currentContext?.findRenderObject() as RenderBox?;
  final RenderBox? ancestorRenderBox = ancestorKey.currentContext?.findRenderObject() as RenderBox?;

  if (childRenderBox == null || ancestorRenderBox == null) return null;

  return childRenderBox.localToGlobal(Offset.zero, ancestor: ancestorRenderBox);
}

bool isOffsetOnElement({
  required Offset offset,
  required Size elementSize,
  required Offset elementPosition,
  double tolerance = 0,
}) {
  final left = elementPosition.dx - tolerance;
  final right = elementPosition.dx + elementSize.width + tolerance;
  final top = elementPosition.dy - tolerance;
  final bottom = elementPosition.dy + elementSize.height + tolerance;

  return offset.dx >= left && offset.dx <= right && offset.dy >= top && offset.dy <= bottom;
}
