import 'package:basics_samples/components/draggable_text.dart';
import 'package:basics_samples/reconstruct_widgets/models.dart';
import 'package:flutter/material.dart';

Offset getOffsetFromTextInformation({
  required TextInformation textInformation,
  required double containerHeight,
  required double containerWidth,
}) {
  final textPainter = TextPainter(
    text: TextSpan(
      text: textInformation.text,
      style: TextStyle(
        fontSize: textInformation.fontSize,
      ),
    ),
    textDirection: TextDirection.ltr,
  )..layout(
      // Prendre en compte le border et padding du widget d'affichage final
      maxWidth: containerWidth -
          SelectableDraggableWidget.widthGap -
          (2 * SelectableDraggableWidget.horizontalPadding) -
          (2 * SelectableDraggableWidget.borderWidth),
    );

  final textPainterSize = textPainter.size;

  final textXproportion = textInformation.proportion.x;
  final textXCenter = (textXproportion * containerWidth);
  final textXLeft = textXCenter - (textPainterSize.width / 2);

  final textYproportion = textInformation.proportion.y;
  final textYCenter = (textYproportion * containerHeight);
  final textYTop = textYCenter - (textPainterSize.height / 2);

  // Prendre en compte le border left et padding left du widget d'affichage final
  final widgetXLeft = textXLeft - (SelectableDraggableWidget.horizontalPadding + SelectableDraggableWidget.borderWidth);

  // Prendre en compte le border top et padding top du widget d'affichage final
  final widgetYTop = textYTop - (SelectableDraggableWidget.verticalPadding + SelectableDraggableWidget.borderWidth);

  return Offset(widgetXLeft, widgetYTop);
}
