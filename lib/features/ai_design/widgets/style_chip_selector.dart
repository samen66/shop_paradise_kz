import 'package:flutter/material.dart';

import '../models/supported_style.dart';

class StyleChipSelector extends StatelessWidget {
  const StyleChipSelector({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final SupportedStyle value;
  final ValueChanged<SupportedStyle> onChanged;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: SupportedStyle.values.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (BuildContext context, int index) {
          final SupportedStyle style = SupportedStyle.values[index];
          final bool selected = style == value;
          return ChoiceChip(
            selected: selected,
            onSelected: (_) => onChanged(style),
            label: Text('${style.emoji} ${style.label}'),
            labelStyle: theme.textTheme.labelLarge?.copyWith(
              color: selected ? colors.onPrimary : colors.onSurface,
              fontWeight: FontWeight.w700,
            ),
            selectedColor: colors.primary,
            backgroundColor: colors.surfaceContainerHighest.withValues(alpha: 0.55),
            side: BorderSide(color: colors.outlineVariant),
          );
        },
      ),
    );
  }
}

