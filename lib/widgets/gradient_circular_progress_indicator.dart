import 'package:flutter/material.dart';
import 'dart:math';

class GradientCircularProgress extends StatelessWidget {
  final double progress; // value between 0.0 and 1.0
  final double strokeWidth;

  const GradientCircularProgress({
    super.key,
    required this.progress,
    this.strokeWidth = 24,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(200, 200),
      painter: _GradientCircularPainter(
        progress: progress,
        strokeWidth: strokeWidth,
      ),
    );
  }
}

class _GradientCircularPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;

  _GradientCircularPainter({
    required this.progress,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = ((size.width - strokeWidth) / 2)+20;

    // Background circle
    final backgroundPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, backgroundPaint);

    final List<Color> gradientColors = progress < 0.25
        ? [Color(0xFFFF6B6B), Color(0xFFB00020), Color(0xFFFF6B6B)] // Red
        : [Color(0xFF00C6FF), Color(0xFF0072FF), Color(0xFF00C6FF)]; // Blue

    final gradient = SweepGradient(
      startAngle: -pi / 2,
      endAngle: 4 * pi / 2,
      tileMode: TileMode.clamp,
      colors:gradientColors,
      stops: [0.0, 0.5, 1.0],
    );


    final rect = Rect.fromCircle(center: center, radius: radius);
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    final angle = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      angle,
      false,
      paint,
    );
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
