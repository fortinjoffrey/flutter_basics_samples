import 'package:flutter/material.dart';

class WidgetToImageWrapper extends StatefulWidget {
  const WidgetToImageWrapper({
    super.key,
    required this.builder,
  });

  final Widget Function(GlobalKey) builder;

  @override
  State<WidgetToImageWrapper> createState() => _WidgetToImageWrapperState();
}

class _WidgetToImageWrapperState extends State<WidgetToImageWrapper> {
  final globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: globalKey,
      child: widget.builder(globalKey),
    );
  }
}