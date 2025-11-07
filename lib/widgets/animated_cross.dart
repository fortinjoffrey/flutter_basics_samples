import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/constants/colors.dart';
import 'package:tic_tac_toe_app/constants/game_constants.dart';

class AnimatedCross extends StatefulWidget {
  final double size;
  final Color color;
  final double strokeWidth;

  const AnimatedCross({
    super.key,
    this.size = 60,
    this.color = kPlayerXColor,
    this.strokeWidth = 8,
  });

  @override
  State<AnimatedCross> createState() => _AnimatedCrossState();
}

class _AnimatedCrossState extends State<AnimatedCross>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: kSymbolAnimationDurationMs),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
            painter: _CrossPainter(
              progress: _controller.value,
              color: widget.color,
              strokeWidth: widget.strokeWidth,
            ),
          );
        },
      ),
    );
  }
}

class _CrossPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  _CrossPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final padding = strokeWidth / 2;
    final adjustedSize = size.width - padding * 2;

    final line1Progress = (progress * 2).clamp(0.0, 1.0);
    if (line1Progress > 0) {
      final startX = padding;
      final startY = padding;
      final endX = padding + adjustedSize * line1Progress;
      final endY = padding + adjustedSize * line1Progress;

      canvas.drawLine(
        Offset(startX, startY),
        Offset(endX, endY),
        paint,
      );
    }

    final line2Progress = ((progress - 0.5) * 2).clamp(0.0, 1.0);
    if (line2Progress > 0) {
      final startX = size.width - padding;
      final startY = padding;
      final endX = size.width - padding - adjustedSize * line2Progress;
      final endY = padding + adjustedSize * line2Progress;

      canvas.drawLine(
        Offset(startX, startY),
        Offset(endX, endY),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_CrossPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
