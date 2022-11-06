import 'package:flutter/material.dart';

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    super.key,
    required this.desktopBuilder,
    required this.mobileBuilder,
  });

  final Widget Function(BuildContext) desktopBuilder;
  final Widget Function(BuildContext) mobileBuilder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 700) {
          return desktopBuilder(context);
        } else {
          return mobileBuilder(context);
        }
      },
    );
  }
}
