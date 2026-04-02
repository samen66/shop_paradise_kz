import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeLoadingSkeleton extends StatelessWidget {
  const HomeLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Shimmer.fromColors(
      baseColor: colorScheme.surfaceContainerHighest,
      highlightColor: colorScheme.surface,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          const SizedBox(height: 12),
          _block(
            height: 44,
            radius: 12,
            margin: const EdgeInsets.symmetric(horizontal: 16),
          ),
          const SizedBox(height: 16),
          _block(
            height: 120,
            radius: 12,
            margin: const EdgeInsets.symmetric(horizontal: 16),
          ),
          const SizedBox(height: 16),
          _sectionSkeleton(),
          _sectionSkeleton(),
          _sectionSkeleton(),
        ],
      ),
    );
  }

  Widget _sectionSkeleton() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _block(
        height: 18,
        width: 120,
        radius: 8,
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      ),
      SizedBox(
        height: 180,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          separatorBuilder: (_, __) => const SizedBox(width: 10),
          itemBuilder: (_, __) => _block(width: 130, height: 180, radius: 12),
        ),
      ),
      const SizedBox(height: 12),
    ],
  );

  Widget _block({
    double? width,
    required double height,
    required double radius,
    EdgeInsetsGeometry? margin,
  }) => Container(
    width: width,
    height: height,
    margin: margin,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(radius),
    ),
  );
}
