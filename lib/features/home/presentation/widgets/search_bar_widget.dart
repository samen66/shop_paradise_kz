import 'package:flutter/material.dart';

import '../../../../core/l10n/l10n_helpers.dart';
import '../../../category_filter/presentation/pages/category_filter_page.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final String searchHint = context.l10n.homeMarketSearchPlaceholderShort;
    final String filterTooltip = context.l10n.homeMarketCategoryFiltersTooltip;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: searchHint,
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: colorScheme.surfaceContainerHighest,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
          IconButton.filledTonal(
            onPressed: () {
              Navigator.of(context).push<void>(
                MaterialPageRoute<void>(
                  fullscreenDialog: true,
                  builder: (BuildContext context) => const CategoryFilterPage(),
                ),
              );
            },
            icon: const Icon(Icons.tune),
            tooltip: filterTooltip,
          ),
        ],
      ),
    );
  }
}
