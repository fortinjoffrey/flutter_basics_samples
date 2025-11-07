import 'package:flutter/material.dart';

class AnimatedBoard extends StatefulWidget {
  final double size;
  final Color lineColor;
  final double lineWidth;

  const AnimatedBoard({
    super.key,
    this.size = 300,
    this.lineColor = Colors.black,
    this.lineWidth = 4,
  });

  @override
  State<AnimatedBoard> createState() => AnimatedBoardState();
}

class AnimatedBoardState extends State<AnimatedBoard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void resetAnimation() {
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _BoardPainter(
              progress: _controller.value,
              lineColor: widget.lineColor,
              lineWidth: widget.lineWidth,
            ),
          );
        },
      ),
    );
  }
}

class _BoardPainter extends CustomPainter {
  final double progress;
  final Color lineColor;
  final double lineWidth;

  _BoardPainter({
    required this.progress,
    required this.lineColor,
    required this.lineWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = lineWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final thirdWidth = size.width / 3;
    final thirdHeight = size.height / 3;

    final verticalCenterY = size.height / 2;
    final verticalLineHeight = size.height * progress / 2;
    canvas.drawLine(
      Offset(thirdWidth, verticalCenterY - verticalLineHeight),
      Offset(thirdWidth, verticalCenterY + verticalLineHeight),
      paint,
    );

    canvas.drawLine(
      Offset(thirdWidth * 2, verticalCenterY - verticalLineHeight),
      Offset(thirdWidth * 2, verticalCenterY + verticalLineHeight),
      paint,
    );

    final horizontalCenterX = size.width / 2;
    final horizontalLineWidth = size.width * progress / 2;
    canvas.drawLine(
      Offset(horizontalCenterX - horizontalLineWidth, thirdHeight),
      Offset(horizontalCenterX + horizontalLineWidth, thirdHeight),
      paint,
    );

    canvas.drawLine(
      Offset(horizontalCenterX - horizontalLineWidth, thirdHeight * 2),
      Offset(horizontalCenterX + horizontalLineWidth, thirdHeight * 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(_BoardPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
