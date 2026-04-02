import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/home_entities.dart';
import '../providers/just_for_you_pagination_controller.dart';
import 'category_section_widget.dart';
import 'product_section_widget.dart';
import 'section_header_widget.dart';

class HomeSectionRenderer extends ConsumerWidget {
  const HomeSectionRenderer({
    super.key,
    required this.section,
  });

  final HomeSectionEntity section;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (section.type.isJustForYou) {
      final JustForYouPaginationState state = ref.watch(
        justForYouPaginationControllerProvider,
      );
      if (state.items.isEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref
              .read(justForYouPaginationControllerProvider.notifier)
              .seed(section);
        });
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SectionHeaderWidget(title: section.title),
          ProductSectionWidget(
            items: state.items.isEmpty ? section.items : state.items,
            layout: section.layout,
            bottomLoader: state.isLoadingMore
                ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
                : null,
          ),
          if (state.errorMessage != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: TextButton(
                onPressed: () => ref
                    .read(justForYouPaginationControllerProvider.notifier)
                    .loadMore(),
                child: const Text('Retry loading more'),
              ),
            ),
        ],
      );
    }
    if (section.type == HomeSectionType.categories) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SectionHeaderWidget(title: section.title),
          CategorySectionWidget(items: section.items),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SectionHeaderWidget(title: section.title),
        ProductSectionWidget(
          items: section.items,
          layout: section.layout,
        ),
      ],
    );
  }
}
