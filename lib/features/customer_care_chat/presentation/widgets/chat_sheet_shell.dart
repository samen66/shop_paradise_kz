import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Bottom sheet chrome: title, scrollable body, [Next] + close actions.
class ChatSheetShell extends StatelessWidget {
  const ChatSheetShell({
    super.key,
    required this.title,
    required this.body,
    required this.onNext,
    required this.onClose,
    this.nextEnabled = true,
    this.nextLabel,
  });

  final String title;
  final Widget body;
  final VoidCallback onNext;
  final VoidCallback onClose;
  final bool nextEnabled;
  final String? nextLabel;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final double maxBody = MediaQuery.sizeOf(context).height * 0.5;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              title,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 16),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: maxBody),
              child: SingleChildScrollView(child: body),
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Expanded(
                  child: FilledButton(
                    onPressed: nextEnabled ? onNext : null,
                    child: Text(nextLabel ?? 'Next'),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 52,
                  height: 52,
                  child: IconButton.filled(
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: onClose,
                    icon: const Icon(Icons.close),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
