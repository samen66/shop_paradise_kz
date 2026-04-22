import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../domain/entities/profile_entities.dart';

class ProfileDonutChart extends StatelessWidget {
  const ProfileDonutChart({
    super.key,
    required this.segments,
    required this.totalLabel,
    required this.totalAmountText,
  });

  final List<ActivitySegmentEntity> segments;
  final String totalLabel;
  final String totalAmountText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      width: 220,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CustomPaint(
            size: const Size(220, 220),
            painter: _DonutPainter(segments: segments),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                totalLabel,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                totalAmountText,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  _DonutPainter({required this.segments});

  final List<ActivitySegmentEntity> segments;

  @override
  void paint(Canvas canvas, Size size) {
    if (segments.isEmpty) {
      return;
    }
    final Offset center = size.center(Offset.zero);
    final double radius = math.min(size.width, size.height) / 2;
    const double strokeWidth = 32;
    final double arcRadius = radius - strokeWidth / 2;
    final double total = segments.fold<double>(
      0,
      (double a, ActivitySegmentEntity s) => a + s.amount,
    );
    if (total <= 0) {
      return;
    }
    double startAngle = -math.pi / 2;
    for (final ActivitySegmentEntity seg in segments) {
      final double sweep = 2 * math.pi * (seg.amount / total);
      final Paint paint = Paint()
        ..color = Color(seg.swatchArgb)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: arcRadius),
        startAngle,
        sweep,
        false,
        paint,
      );
      startAngle += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant _DonutPainter oldDelegate) {
    return oldDelegate.segments != segments;
  }
}
