import 'package:flutter/material.dart';

/// Temporary placeholder until feature screens exist.
class ShellTabPlaceholderPage extends StatelessWidget {
  const ShellTabPlaceholderPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ColoredBox(
      color: scheme.surface,
      child: Center(
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
