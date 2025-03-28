import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/size_util.dart';

class KnowTextHeightBeforeBuildWidget extends StatefulWidget {
  const KnowTextHeightBeforeBuildWidget({
    super.key,
    required this.availableHeight,
    required this.availableWidth,
    required this.responses,
    required this.question,
  });

  final double availableHeight;
  final double availableWidth;
  final List<String> responses;
  final String question;

  @override
  State<KnowTextHeightBeforeBuildWidget> createState() => _KnowTextHeightBeforeBuildWidgetState();
}

class _KnowTextHeightBeforeBuildWidgetState extends State<KnowTextHeightBeforeBuildWidget> {
  static const double widgetPadding = 16;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // SizeUtil.getTextHeight(
    //   context,
    //   widget.question,
    //   widget.availableWidth - widgetPadding * 2,
    // );
  }

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = DefaultTextStyle.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: widgetPadding),
      child: LayoutBuilder(builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'calculated height: ${SizeUtil.getTextHeight(
                context,
                widget.question,
                widget.availableWidth - widgetPadding * 2,
              )}',
            ),
            const SizedBox(height: 16),
            Text(
              widget.question,
              // maxLines: 10,
              style: TextStyle(
                fontSize: defaultTextStyle.style.fontSize,
                fontWeight: defaultTextStyle.style.fontWeight,
                height: defaultTextStyle.style.height,
                letterSpacing: defaultTextStyle.style.letterSpacing,
                textBaseline: TextBaseline.alphabetic,
              ),
            ),
          ],
        );
      }),
    );
  }
}
