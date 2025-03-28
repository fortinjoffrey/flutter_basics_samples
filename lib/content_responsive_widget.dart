// ignore_for_file: avoid_print

import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/size_util.dart';
import 'package:collection/collection.dart';

enum Layout {
  extended,
  collapsed,
}

class ContentResponsiveWidget extends StatelessWidget {
  const ContentResponsiveWidget({
    super.key,
    required this.responses,
    required this.title,
    this.footerText,
  });

  final List<String> responses;
  final String title;
  final String? footerText;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return _ContentResponsiveWidget(
            availableHeight: constraints.maxHeight,
            availableWidth: constraints.maxWidth,
            responses: responses,
            title: title,
            footerText: footerText,
          );
        },
      ),
    );
  }
}

class _ContentResponsiveWidget extends StatefulWidget {
  const _ContentResponsiveWidget({
    required this.availableHeight,
    required this.availableWidth,
    required this.responses,
    required this.title,
    this.footerText,
  });

  final double availableHeight;
  final double availableWidth;
  final List<String> responses;
  final String title;
  final String? footerText;

  @override
  State<_ContentResponsiveWidget> createState() => _ContentResponsiveWidgetState();
}

class _ContentResponsiveWidgetState extends State<_ContentResponsiveWidget> {
  // ---------------------------- CONSTANTS ----------------------------

  // PADDINGS
  static const double widgetPadding = 16;
  static const double responseHorizontalPadding = 16;
  static const double responseVerticalPadding = 8;
  static const double paddingHeightBetweenQuestionAndResponses = 16;
  static const double paddingHeightBetweenResponsesAndFooter = 16;
  static const double separatorHeightBetweenResponses = 1;

  // FONT SIZES
  static const double titleMinFontSize = 14;
  static const double titleMaxFontSize = 36;
  static const FontWeight titleFontWeight = FontWeight.w600;
  static const double footerFontSize = 14;

  Layout _layout = Layout.extended;

  void _computeLayout() {
    print('widget.availableHeight: ${widget.availableHeight}');
    print('widget.availableWidth: ${widget.availableWidth}');
    // ---------------------------- QUESTION HEIGHT ----------------------------
    final questionHeight = SizeUtil.getTextHeight(
      context,
      widget.title,
      widget.availableWidth - widgetPadding * 2,
      fontSize: titleMinFontSize,
      fontWeight: titleFontWeight,
      printDebug: true,
    );
    print('questionHeight: $questionHeight');

    print('paddingHeightBetweenQuestionAndResponses: $paddingHeightBetweenQuestionAndResponses');

    // ---------------------------- RESPONSES HEIGHTS ----------------------------

    double responsesHeight = 0;

    for (var i = 0; i < widget.responses.length; i++) {
      final response = widget.responses[i];
      final height = SizeUtil.getTextHeight(
        context,
        response,
        widget.availableWidth - widgetPadding * 2 - responseHorizontalPadding * 2,
        maxLines: 2,
      );
      print('response[$i]: $response, text height: $height');
      final totalHeight = height + responseVerticalPadding * 2;
      print('text with padding: $totalHeight');
      responsesHeight += totalHeight;

      if (i < widget.responses.length - 1) {
        print('text with padding and separator: ${totalHeight + separatorHeightBetweenResponses}');
        responsesHeight += separatorHeightBetweenResponses;
      }
    }
    print('responsesHeight: $responsesHeight');
    print('paddingHeightBetweenResponsesAndFooter: $paddingHeightBetweenResponsesAndFooter');

    // ---------------------------- FOOTER HEIGHT ----------------------------
    final footerHeight = widget.footerText != null
        ? max(
            48,
            SizeUtil.getTextHeight(
              context,
              widget.footerText!,
              widget.availableWidth - widgetPadding * 2,
              fontSize: footerFontSize,
            ),
          )
        : 0;

    // ---------------------------- SUM HEIGHT ----------------------------
    final sumHeight = questionHeight +
        paddingHeightBetweenQuestionAndResponses +
        responsesHeight +
        paddingHeightBetweenResponsesAndFooter +
        footerHeight;

    print(
      '$questionHeight + $paddingHeightBetweenQuestionAndResponses + $responsesHeight + $paddingHeightBetweenResponsesAndFooter + $footerHeight = $sumHeight',
    );

    if (sumHeight > widget.availableHeight) {
      print('sumHeight: $sumHeight > widget.availableHeight: ${widget.availableHeight}');
      print('WARNING: sumHeight is greater than availableHeight');
      _layout = Layout.collapsed;
    } else {
      print('sumHeight: $sumHeight <= widget.availableHeight: ${widget.availableHeight}');
      _layout = Layout.extended;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _computeLayout();
  }

  @override
  void didUpdateWidget(covariant _ContentResponsiveWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.responses != widget.responses ||
        oldWidget.title != widget.title ||
        oldWidget.footerText != widget.footerText ||
        oldWidget.availableHeight != widget.availableHeight ||
        oldWidget.availableWidth != widget.availableWidth) {
      _computeLayout();
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = DefaultTextStyle.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: widgetPadding),
      child: LayoutBuilder(builder: (context, constraints) {
        print('constraints.maxHeight: ${constraints.maxHeight}');
        print('constraints.maxWidth: ${constraints.maxWidth}');

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: AutoSizeText(
                  widget.title,
                  maxLines: 100,
                  maxFontSize: titleMaxFontSize,
                  minFontSize: titleMinFontSize,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: titleMaxFontSize,
                    fontWeight: titleFontWeight,
                    height: defaultTextStyle.style.height,
                    letterSpacing: defaultTextStyle.style.letterSpacing,
                  ),
                ),
              ),
              const SizedBox(height: paddingHeightBetweenQuestionAndResponses),
              switch (_layout) {
                Layout.extended => _ResponsesSection(
                    responses: widget.responses,
                    responseVerticalPadding: responseVerticalPadding,
                    responseHorizontalPadding: responseHorizontalPadding,
                    separatorHeightBetweenResponses: separatorHeightBetweenResponses,
                  ),
                Layout.collapsed => ElevatedButton(
                    onPressed: () {},
                    child: const Text('Show more'),
                  ),
              },
              if (widget.footerText != null) ...[
                const SizedBox(height: paddingHeightBetweenResponsesAndFooter),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    widget.footerText!,
                    style: TextStyle(fontSize: footerFontSize),
                  ),
                ),
                // Text(
                //   widget.footerText!,
                //   style: TextStyle(fontSize: footerFontSize),
                // ),
              ],
            ],
          ),
        );
      }),
    );
  }
}

class _ResponsesSection extends StatelessWidget {
  const _ResponsesSection({
    required this.responses,
    required this.responseVerticalPadding,
    required this.responseHorizontalPadding,
    required this.separatorHeightBetweenResponses,
  });

  final List<String> responses;
  final double responseVerticalPadding;
  final double responseHorizontalPadding;
  final double separatorHeightBetweenResponses;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          ...responses.mapIndexed(
            (index, response) => Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: responseVerticalPadding,
                    horizontal: responseHorizontalPadding,
                  ),
                  child: Text(
                    response,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (index < responses.length - 1) Divider(height: separatorHeightBetweenResponses),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
