import 'dart:math';

import 'package:flutter/material.dart';

enum TriangleDirection {
  UP,
  DOWN,
  LEFT,
  RIGHT,
}

class Triangle extends StatelessWidget {
  final Color color;
  final Size size;
  final TriangleDirection direction;

  const Triangle({
    Key? key,
    required this.size,
    required this.color,
    this.direction = TriangleDirection.UP,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _TrianglePainter(
        color: color,
        variant: direction,
      ),
      child: SizedBox(
        width: size.width,
        height: size.height,
      ),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  final Color color;
  final TriangleDirection variant;

  static const double radius = 1.5;

  _TrianglePainter({required this.color, required this.variant});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeJoin = StrokeJoin.round;

    switch (variant) {
      case TriangleDirection.LEFT:
        _drawLeft(canvas, size, paint);
        break;
      case TriangleDirection.RIGHT:
        _drawRight(canvas, size, paint);
        break;
      case TriangleDirection.DOWN:
        _drawDown(canvas, size, paint);
        break;
      case TriangleDirection.UP:
      default:
        _drawUp(canvas, size, paint);
        break;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  void _drawUp(Canvas canvas, Size size, Paint paint) {
    final path = Path()
      ..moveTo(0, size.height + 1)
      ..lineTo(size.width / 2 + radius, 1 + radius)
      ..arcTo(Rect.fromPoints(Offset(size.width / 2 + radius, 1 + radius), Offset(size.width / 2 - radius, 1 + radius)),
          -pi, pi, true)
      ..lineTo(size.width, size.height + 1)
      ..lineTo(0, size.height + 1);

    canvas.drawPath(path, paint);
  }

  void _drawDown(Canvas canvas, Size size, Paint paint) {
    final path = Path()
      ..moveTo(0, -1)
      ..lineTo(size.width, -1)
      ..lineTo(size.width / 2 + radius, size.height - 1 - radius)
      ..arcTo(
          Rect.fromPoints(Offset(size.width / 2 + radius, size.height - 1 - radius),
              Offset(size.width / 2 - radius, size.height - 1 - radius)),
          -pi,
          pi,
          true)
      ..lineTo(0, -1);

    canvas.drawPath(path, paint);
  }

  void _drawLeft(Canvas canvas, Size size, Paint paint) {
    final path = Path()
      ..moveTo(1 + radius, size.height / 2 - radius)
      ..lineTo(size.width + 1, 0)
      ..lineTo(size.width + 1, size.height)
      ..lineTo(1 + radius, size.height / 2 + radius)
      ..arcTo(
          Rect.fromPoints(Offset(1 + radius, size.height / 2 + radius), Offset(1 + radius, size.height / 2 - radius)),
          -pi,
          pi,
          true);

    canvas.drawPath(path, paint);
  }

  void _drawRight(Canvas canvas, Size size, Paint paint) {
    final path = Path()
      ..moveTo(size.width - 1 - radius, size.height / 2 + radius)
      ..lineTo(-1, size.height)
      ..lineTo(-1, 0)
      ..lineTo(size.width - 1 - radius, size.height / 2 - radius)
      ..arcTo(
          Rect.fromPoints(Offset(size.width - 1 - radius, size.height / 2 - radius),
              Offset(size.width - 1 - radius, size.height / 2 + radius)),
          -pi,
          pi,
          true);

    canvas.drawPath(path, paint);
  }
}