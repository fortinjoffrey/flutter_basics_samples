import 'package:basics_samples/components/reconstruct_widget/reconstruct_widget_cubit.dart';
import 'package:basics_samples/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReconstructWidget extends StatefulWidget {
  const ReconstructWidget({super.key, required this.json});

  final Map<String, dynamic> json;

  @override
  State<ReconstructWidget> createState() => _ReconstructWidgetState();
}

class _ReconstructWidgetState extends State<ReconstructWidget> {
  @override
  void didUpdateWidget(covariant ReconstructWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    final t = oldWidget.json;
    final r = widget.json;
    if (t != r) context.read<ReconstructWidgetCubit>().refresh(r);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReconstructWidgetCubit, ReconstructWidgetState>(
      builder: (context, state) {
        if (state is ReconstructWidgetStateLoading) return const CircularProgressIndicator();
        if (state is ReconstructWidgetStateComplete) return _Complete(positionInformation: state.positionInformation);
        return const SizedBox.shrink();
      },
    );
  }
}

class _Complete extends StatefulWidget {
  const _Complete({required this.positionInformation});

  final PositionInformation positionInformation;

  @override
  State<_Complete> createState() => _CompleteState();
}

class _CompleteState extends State<_Complete> {
  double mockedProportion = 1;

  @override
  Widget build(BuildContext context) {
    final textInformation = widget.positionInformation.textInformation;

    final textPainter = TextPainter(
      text: TextSpan(
        text: textInformation.text,
        style: TextStyle(
          fontSize: textInformation.fontSize * mockedProportion,
        ),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();

    final textPainterSize = textPainter.size;

    final containerProportion = (widget.positionInformation.containerInformation.widthProportion) * mockedProportion;
    final containerWidth = (MediaQuery.of(context).size.width * containerProportion);
    final containerAspectRatio = widget.positionInformation.containerInformation.aspectRatio;
    final containerHeight = (containerWidth / containerAspectRatio);

    final textXproportion = widget.positionInformation.textInformation.proportion.x;
    final textXCenter = (textXproportion * containerWidth);
    final textXLeft = textXCenter - (textPainterSize.width / 2);

    final textYproportion = widget.positionInformation.textInformation.proportion.y;
    final textYCenter = (textYproportion * containerHeight);
    final textYTop = textYCenter - (textPainterSize.height / 2);

    return MediaQuery(
      data: const MediaQueryData(textScaleFactor: 1.0),
      child: Center(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Text('Proportion: ${mockedProportion}')),
                Expanded(
                  flex: 3,
                  child: Slider(
                    value: mockedProportion,
                    max: 2,
                    divisions: 10,
                    label: 'Proportion: ${mockedProportion.toString()}',
                    onChanged: (double value) {
                      setState(() {
                        mockedProportion = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  color: Colors.blue,
                  height: containerHeight,
                  width: containerWidth,
                ),
                Container(
                  width: 1,
                  height: containerHeight,
                  color: Colors.green,
                ),
                Container(
                  width: containerWidth,
                  height: 1,
                  color: Colors.green,
                ),
                Positioned(
                  top: textYTop,
                  left: textXLeft,
                  child: Text(
                    textInformation.text,
                    style: TextStyle(
                      fontSize: textInformation.fontSize * mockedProportion,
                    ),
                  ),
                ),
                // Align(
                //   alignment: Alignment.center,
                //   child: Text(
                //      textInformation.text,
                //     style: TextStyle(
                //        fontSize: textInformation.fontSize,
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
