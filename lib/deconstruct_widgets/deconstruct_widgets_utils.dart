import 'package:basics_samples/components/draggable_text.dart';
import 'package:basics_samples/editor_screen/editor_utils.dart';
import 'package:basics_samples/reconstruct_widgets/models.dart';
import 'package:flutter/material.dart';

// enum SelectableDraggableWidgetType { text, icon }
class WidgetInfoForExport {
  final String text;
  final double fontSize;
  final Color color;
  final GlobalKey key;

  const WidgetInfoForExport({
    required this.key,
    required this.text,
    required this.fontSize,
    required this.color,
  });

  factory WidgetInfoForExport.fromSelectableDraggableWidget(SelectableDraggableWidget draggableWidget) {
    if (draggableWidget.type == SelectableDraggableWidgetType.text) {
      return WidgetInfoForExport(
        key: draggableWidget.key as GlobalKey,
        text: draggableWidget.title!,
        fontSize: draggableWidget.fontSize!,
        color: draggableWidget.color!,
      );
    }
    throw Exception();
  }
}

Map<String, dynamic> exportWidgetsInformation({
  required GlobalKey containerKey,
  required double containerAspectRatio,
  required double containerWidthProportion,
  required List<WidgetInfoForExport> widgetInfos,
}) {
  final containerPosition = getOffsetFromKey(containerKey);
  final containerSize = getSizeFromKey(containerKey);

  if (containerPosition == null || containerSize == null) return {};

  List<TextInformation> infos = [];

  for (final widgetInfo in widgetInfos) {
    final widgetPositiion = getOffsetFromKey(widgetInfo.key);
    final widgetSize = getSizeFromKey(widgetInfo.key);

    if (widgetPositiion == null || widgetSize == null) continue;

    final textXStartInContainer = widgetPositiion.dx - containerPosition.dx;
    final textXEndInContainer = textXStartInContainer + widgetSize.width;
    final textXCenter = (textXStartInContainer + textXEndInContainer) / 2;
    final containerXend = containerSize.width;
    final textXProportion = (textXCenter / containerXend);

    final textYStartInContainer = widgetPositiion.dy - containerPosition.dy;
    final textYEndInContainer = textYStartInContainer + widgetSize.height;
    final textYCenter = (textYStartInContainer + textYEndInContainer) / 2;
    final containerYend = containerSize.height;
    final textYProportion = (textYCenter / containerYend);

    //TODO: arrondir ici au centième près
    final roundedTextXProportion = (textXProportion * 100).roundToDouble() / 100;
    final roundedTextYProportion = (textYProportion * 100).roundToDouble() / 100;
    final textProportion = OffsetProportion(x: roundedTextXProportion, y: roundedTextYProportion);

    final textInformation = TextInformation(
      text: widgetInfo.text,
      proportion: textProportion,
      fontSize: widgetInfo.fontSize,
      color: widgetInfo.color,
    );

    infos.add(textInformation);
  }

  final positionInformation = PositionInformation(
    textInformations: infos,
    containerInformation:
        ContainerInformation(aspectRatio: containerAspectRatio, widthProportion: containerWidthProportion),
  );

  print(positionInformation.toMap());

  return positionInformation.toMap();
}
