import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

abstract class WidgetToImageUtil {
  static Future<Uint8List?> capture(GlobalKey key) async {
    final context = key.currentContext;

    if (context == null) return null;

    try {
      final RenderRepaintBoundary boundary = context.findRenderObject() as RenderRepaintBoundary;

      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ImageByteFormat.png);

      if (byteData == null) return null;

      final bytes = byteData.buffer.asUint8List();

      return bytes;
    } catch (e) {
      return null;
    }
  }
}
