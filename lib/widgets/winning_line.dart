import 'package:flutter/material.dart';

class WinningLine extends StatefulWidget {
  final List<int> winningLine;
  final double cellSize;
  final Color color;
  final double strokeWidth;
  final VoidCallback? onAnimationComplete;

  const WinningLine({
    super.key,
    required this.winningLine,
    required this.cellSize,
    this.color = Colors.green,
    this.strokeWidth = 8,
    this.onAnimationComplete,
  });

  @override
  State<WinningLine> createState() => _WinningLineState();
}

class _WinningLineState extends State<WinningLine>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _controller.forward().then((_) {
      if (mounted) {
        widget.onAnimationComplete?.call();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Offset _getPositionForIndex(int index) {
    final row = index ~/ 3;
    final col = index % 3;
    final centerX = col * widget.cellSize + widget.cellSize / 2;
    final centerY = row * widget.cellSize + widget.cellSize / 2;
    return Offset(centerX, centerY);
  }

  @override
  Widget build(BuildContext context) {
    final start = _getPositionForIndex(widget.winningLine[0]);
    final end = _getPositionForIndex(widget.winningLine[2]);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.cellSize * 3, widget.cellSize * 3),
          painter: _WinningLinePainter(
            start: start,
            end: end,
            progress: _controller.value,
            color: widget.color,
            strokeWidth: widget.strokeWidth,
          ),
        );
      },
    );
  }
}

class _WinningLinePainter extends CustomPainter {
  final Offset start;
  final Offset end;
  final double progress;
  final Color color;
  final double strokeWidth;

  _WinningLinePainter({
    required this.start,
    required this.end,
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (progress == 0) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final currentEnd = Offset(
      start.dx + (end.dx - start.dx) * progress,
      start.dy + (end.dy - start.dy) * progress,
    );

    canvas.drawLine(start, currentEnd, paint);
  }

  @override
  bool shouldRepaint(_WinningLinePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
