import 'package:flutter/material.dart';

import '../../../../core/l10n/l10n_helpers.dart';

class HomeErrorState extends StatelessWidget {
  const HomeErrorState({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.error_outline, color: colorScheme.error, size: 36),
            const SizedBox(height: 12),
            SelectableText.rich(
              TextSpan(
                text: message,
                style: textTheme.bodyMedium?.copyWith(color: colorScheme.error),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: onRetry,
              child: Text(context.l10n.commonRetry),
            ),
          ],
        ),
      ),
    );
  }
}
