import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../home/presentation/providers/just_for_you_pagination_controller.dart';
import '../../domain/entities/category_filter_entities.dart';
import '../providers/category_filter_providers.dart';
import '../widgets/category_parent_expansion_tile.dart';

/// Full-screen category filter: accordion parents, subcategory grid, Apply/Clear.
class CategoryFilterPage extends ConsumerStatefulWidget {
  const CategoryFilterPage({super.key});

  @override
  ConsumerState<CategoryFilterPage> createState() => _CategoryFilterPageState();
}

class _CategoryFilterPageState extends ConsumerState<CategoryFilterPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(categoryFilterDraftProvider.notifier).initFromApplied();
      ref.invalidate(categoryTreeProvider);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _onApply() async {
    final Set<String> draft = ref.read(categoryFilterDraftProvider);
    ref.read(appliedCategoryFilterProvider.notifier).setAll(draft);
    if (context.mounted) {
      Navigator.of(context).pop();
    }
    await ref
        .read(justForYouPaginationControllerProvider.notifier)
        .refreshFromAppliedFilters();
  }

  void _onClearDraft() {
    ref.read(categoryFilterDraftProvider.notifier).clearDraft();
  }

  Future<void> _onClearAppliedAndDraft() async {
    ref.read(categoryFilterDraftProvider.notifier).clearDraft();
    ref.read(appliedCategoryFilterProvider.notifier).clearAll();
    await ref
        .read(justForYouPaginationControllerProvider.notifier)
        .refreshFromAppliedFilters();
  }

  void _toggleSelectAll(List<CategoryNodeEntity> roots) {
    final List<String> leaves = collectLeafCategoryIds(roots);
    final Set<String> draft = ref.read(categoryFilterDraftProvider);
    final bool allSelected = leaves.isNotEmpty && leaves.every(draft.contains);
    if (allSelected) {
      ref.read(categoryFilterDraftProvider.notifier).clearDraft();
    } else {
      ref.read(categoryFilterDraftProvider.notifier).setAll(leaves.toSet());
    }
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<CategoryNodeEntity>> treeAsync = ref.watch(
      categoryTreeProvider,
    );
    final Set<String> draft = ref.watch(categoryFilterDraftProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Categories',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Close',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: treeAsync.maybeWhen(
              data: (List<CategoryNodeEntity> roots) =>
                  () => _toggleSelectAll(roots),
              orElse: () => null,
            ),
            child: const Text('Select all'),
          ),
          TextButton(onPressed: _onClearDraft, child: const Text('Clear')),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: TextField(
                controller: _searchController,
                textInputAction: TextInputAction.search,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  hintText: 'Search categories',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (_) => setState(() {}),
              ),
            ),
            Expanded(
              child: treeAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (Object err, StackTrace stack) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.error_outline,
                          color: Theme.of(context).colorScheme.error,
                          size: 36,
                        ),
                        const SizedBox(height: 12),
                        SelectableText.rich(
                          TextSpan(
                            text: err.toString(),
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        FilledButton(
                          onPressed: () =>
                              ref.read(categoryTreeProvider.notifier).reload(),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                ),
                data: (List<CategoryNodeEntity> roots) {
                  if (roots.isEmpty) {
                    return Center(
                      child: Text(
                        'No categories',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 100),
                    itemCount: roots.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CategoryParentExpansionTile(
                        node: roots[index],
                        selectedIds: draft,
                        onToggleLeaf: (String id) => ref
                            .read(categoryFilterDraftProvider.notifier)
                            .toggle(id),
                        searchQuery: _searchController.text,
                      );
                    },
                  );
                },
              ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    OutlinedButton(
                      onPressed: () {
                        _onClearAppliedAndDraft();
                      },
                      child: const Text('Clear all filters'),
                    ),
                    const SizedBox(height: 8),
                    FilledButton(
                      onPressed: _onApply,
                      child: const Text('Apply filters'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
