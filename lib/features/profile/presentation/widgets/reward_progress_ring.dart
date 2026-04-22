import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Single-arc progress ring (0..1) with optional completion check badge.
class RewardProgressRing extends StatelessWidget {
  const RewardProgressRing({
    super.key,
    required this.progress,
    required this.child,
    this.size = 88,
    this.strokeWidth = 6,
    this.progressColor,
    this.trackColor,
    this.showCompletedBadge = false,
  });

  final double progress;
  final Widget child;
  final double size;
  final double strokeWidth;
  final Color? progressColor;
  final Color? trackColor;
  final bool showCompletedBadge;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final Color track =
        trackColor ?? scheme.primary.withValues(alpha: 0.15);
    final Color prog = progressColor ?? AppColors.primary;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: <Widget>[
          CustomPaint(
            size: Size(size, size),
            painter: _ArcRingPainter(
              progress: progress.clamp(0.0, 1.0),
              strokeWidth: strokeWidth,
              trackColor: track,
              progressColor: prog,
            ),
          ),
          child,
          if (showCompletedBadge)
            Positioned(
              right: 0,
              top: 0,
              child: Material(
                color: AppColors.primary,
                shape: const CircleBorder(),
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.check_rounded,
                    size: 14,
                    color: AppColors.onPrimary,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ArcRingPainter extends CustomPainter {
  _ArcRingPainter({
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
    final double radius = math.min(size.width, size.height) / 2 - strokeWidth / 2;
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
  bool shouldRepaint(covariant _ArcRingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.progressColor != progressColor;
  }
}
