import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class SizeUtil {
  static double getTextHeight(
    BuildContext context,
    String text,
    double maxWidth, {
    int? maxLines,
    double? fontSize,
    FontWeight? fontWeight,
    bool printDebug = false,
  }) {
    final defaultTextStyle = DefaultTextStyle.of(context);

    final questionTextPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          height: defaultTextStyle.style.height,
          letterSpacing: defaultTextStyle.style.letterSpacing,
          fontWeight: fontWeight ?? defaultTextStyle.style.fontWeight,
          fontStyle: defaultTextStyle.style.fontStyle,
          fontFamily: defaultTextStyle.style.fontFamily,
          fontFamilyFallback: defaultTextStyle.style.fontFamilyFallback,
          fontSize: fontSize ?? defaultTextStyle.style.fontSize,
        ),
      ),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
      textScaler: MediaQuery.textScalerOf(context),
    )..layout(
        maxWidth: maxWidth,
      );

    if (printDebug) {
      if (kDebugMode) {
        print("maxWidth: $maxWidth");
        print('Nombre de lignes: ${questionTextPainter.computeLineMetrics().length}');
        print('TextPainter height: ${questionTextPainter.height}');
      }
    }

    return questionTextPainter.height;
  }
}
