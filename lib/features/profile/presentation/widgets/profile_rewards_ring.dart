import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Thick single progress ring with centered icon (profile hub rewards summary).
class ProfileRewardsRing extends StatelessWidget {
  const ProfileRewardsRing({
    super.key,
    required this.progress,
    required this.icon,
    this.size = 96,
    this.strokeWidth = 10,
    this.progressColor = const Color(0xFFFF7F6E),
    this.trackColor = const Color(0xFFFFE5E0),
  });

  final double progress;
  final IconData icon;
  final double size;
  final double strokeWidth;
  final Color progressColor;
  final Color trackColor;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CustomPaint(
            size: Size(size, size),
            painter: _ThickRingPainter(
              progress: progress.clamp(0.0, 1.0),
              strokeWidth: strokeWidth,
              trackColor: trackColor,
              progressColor: progressColor,
            ),
          ),
          Icon(icon, size: 32, color: scheme.primary),
        ],
      ),
    );
  }
}

class _ThickRingPainter extends CustomPainter {
  _ThickRingPainter({
    required this.progress,
    required this.strokeWidth,
    required this.trackColor,
    required this.progressColor,
  });

  final double progress;
  final double strokeWidth;
  final Color trackColor;
  final Color progressColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final double radius =
        math.min(size.width, size.height) / 2 - strokeWidth / 2;
    const double start = -math.pi / 2;
    final double sweep = 2 * math.pi * progress;

    final Paint trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final Paint progPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0,
      2 * math.pi,
      false,
      trackPaint,
    );
    if (progress > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        start,
        sweep,
        false,
        progPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ThickRingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.progressColor != progressColor;
  }
}
