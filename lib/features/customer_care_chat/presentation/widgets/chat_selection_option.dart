import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class ChatSelectionOption extends StatelessWidget {
  const ChatSelectionOption({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final TextStyle? base = Theme.of(context).textTheme.titleSmall;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: selected ? AppColors.primary : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(
            color: selected ? AppColors.primary : AppColors.primary,
            width: selected ? 0 : 1.2,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Row(
              children: <Widget>[
                if (selected) ...<Widget>[
                  Icon(Icons.check_circle, color: AppColors.onPrimary, size: 22),
                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: Text(
                    label,
                    style: base?.copyWith(
                      color: selected ? AppColors.onPrimary : AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
