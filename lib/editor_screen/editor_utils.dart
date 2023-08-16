import 'package:flutter/material.dart';

Offset? getOffsetFromKey(GlobalKey key) {
    final keyContext = key.currentContext;
    final stackSize = keyContext?.size;
    if (keyContext == null || stackSize == null) return null;

    final renderBox = keyContext.findRenderObject() as RenderBox;
    return renderBox.localToGlobal(Offset.zero);
  }

  Offset? getLocalOffsetFromParent(GlobalKey childKey, GlobalKey parentKey) {
    final childKeyContext = childKey.currentContext;
    final childSize = childKeyContext?.size;
    if (childKeyContext == null || childSize == null) return null;

    final childRenderBox = childKeyContext.findRenderObject() as RenderBox;
    final childLocalToGlobal = childRenderBox.localToGlobal(Offset.zero);

    final parentKeyContext = parentKey.currentContext;
    final parentSize = parentKeyContext?.size;
    if (parentKeyContext == null || parentSize == null) return null;

    final parentRenderBox = parentKeyContext.findRenderObject() as RenderBox;
    return parentRenderBox.globalToLocal(childLocalToGlobal);
  }

  Size? getSizeFromKey(GlobalKey key) {
    return key.currentContext?.size;
  }