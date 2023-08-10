import 'package:flutter/material.dart';

abstract class OffsetUtils {
  static bool isTapPositionInElement({
    required Size elementSize,
    required Offset elementPosition,
    required Offset tapPosition,
  }) {
    return (elementPosition.dx <= tapPosition.dx && tapPosition.dx <= (elementPosition.dx + elementSize.width)) &&
        (elementPosition.dy <= tapPosition.dy && tapPosition.dy <= (elementPosition.dy + elementSize.height));
  }

  static bool isElementHasAtLeastOnePointInsideParent({
    required Offset parentOffset,
    required Size parentSize,
    required Offset childOffset,
    required Size childSize,
  }) {
    final parentXstart = parentOffset.dx;
    final parentXend = parentOffset.dx + parentSize.width;
    final parentYstart = parentOffset.dy;
    final parentYend = parentOffset.dy + parentSize.height;

    final aOffset = childOffset;
    final bOffset = Offset(childOffset.dx + childSize.width, childOffset.dy);
    final cOffset = Offset(childOffset.dx + childSize.width, childOffset.dy + childSize.height);
    final dOffset = Offset(childOffset.dx, childOffset.dy + childSize.height);

    final points = [aOffset, bOffset, cOffset, dOffset];

    for (final point in points) {
      if (point.dx > parentXstart && point.dx < parentXend && point.dy > parentYstart && point.dy < parentYend) {
        return true;
      }
    }

    return false;
  }
}
