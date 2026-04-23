import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class ChatComposerBar extends StatelessWidget {
  const ChatComposerBar({
    super.key,
    required this.hint,
    required this.onAttach,
    required this.onMenu,
  });

  final String hint;
  final VoidCallback onAttach;
  final VoidCallback onMenu;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.blobLightBlue.withValues(alpha: 0.55),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  hint,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                onPressed: onAttach,
                icon: const Icon(Icons.attach_file_outlined),
                color: AppColors.primary,
                style: IconButton.styleFrom(
                  side: const BorderSide(color: AppColors.primary),
                ),
              ),
              const SizedBox(width: 4),
              IconButton(
                onPressed: onMenu,
                icon: const Icon(Icons.menu),
                color: AppColors.primary,
                style: IconButton.styleFrom(
                  side: const BorderSide(color: AppColors.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
