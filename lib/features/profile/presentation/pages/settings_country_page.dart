import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../data/shipping_demo_countries.dart';
import '../widgets/settings_subpage_header.dart';

/// **Settings** → **Country**: alphabetical picker; pops with selected name.
class SettingsCountryPage extends StatelessWidget {
  const SettingsCountryPage({super.key, this.selectedName});

  final String? selectedName;

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[];
    String? lastLetter;
    for (final String name in kShippingDemoCountries) {
      final String letter = name[0].toUpperCase();
      if (letter != lastLetter) {
        children.add(_LetterHeader(letter: letter));
        lastLetter = letter;
      }
      final bool selected =
          selectedName != null && selectedName!.toLowerCase() == name.toLowerCase();
      children.add(
        _CountryRow(
          name: name,
          selected: selected,
          onTap: () => Navigator.of(context).pop<String>(name),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SettingsSubpageHeader(subtitle: 'Country'),
            if (selectedName != null && selectedName!.trim().isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.blobLightBlue.withValues(alpha: 0.75),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            selectedName!.trim(),
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check_rounded,
                            color: AppColors.onPrimary,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                children: children,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LetterHeader extends StatelessWidget {
  const _LetterHeader({required this.letter});

  final String letter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            letter,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}

class _CountryRow extends StatelessWidget {
  const _CountryRow({
    required this.name,
    required this.selected,
    required this.onTap,
  });

  final String name;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected
          ? AppColors.blobLightBlue.withValues(alpha: 0.45)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              if (selected)
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: AppColors.onPrimary,
                    size: 16,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
