import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Circular brand logo (light/dark SVG) with async load and fallback icon.
class WelcomeLogo extends StatelessWidget {
  const WelcomeLogo({super.key, required this.brandLabel});

  final String brandLabel;

  static const double _size = 240;
  static const String _lightAsset = 'assets/images/logo_light.svg';
  static const String _darkAsset = 'assets/images/logo_dark.svg';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    final bool isDark = theme.brightness == Brightness.dark;
    final String assetPath = isDark ? _darkAsset : _lightAsset;
    final double shadowAlpha = isDark ? 0.35 : 0.08;
    return Center(
      child: Container(
        width: _size,
        height: _size,
        decoration: BoxDecoration(
          color: scheme.surface,
          shape: BoxShape.circle,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withValues(alpha: shadowAlpha),
              blurRadius: 28,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: FutureBuilder<String>(
            future: rootBundle.loadString(assetPath),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasError) {
                return Icon(
                  Icons.image_not_supported_outlined,
                  size: 56,
                  color: scheme.primary,
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(width: 56, height: 56);
              }
              final String? data = snapshot.data;
              if (data == null || data.isEmpty) {
                return Icon(
                  Icons.image_not_supported_outlined,
                  size: 56,
                  color: scheme.primary,
                );
              }
              return Semantics(
                label: brandLabel,
                child: SvgPicture.string(
                  data,
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
