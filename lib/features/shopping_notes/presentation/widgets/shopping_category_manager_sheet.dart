import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/l10n_helpers.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/spending_category_entity.dart';
import '../../domain/repositories/shopping_notes_repository.dart';
import '../providers/shopping_notes_providers.dart';

/// Bottom sheet: CRUD for [SpendingCategoryEntity] (second domain type).
class ShoppingCategoryManagerSheet extends ConsumerWidget {
  const ShoppingCategoryManagerSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext ctx) {
        return const SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 8),
            child: ShoppingCategoryManagerSheet(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = context.l10n;
    final AsyncValue<List<SpendingCategoryEntity>> categories =
        ref.watch(spendingCategoriesStreamProvider);
    final ShoppingNotesRepository repo =
        ref.read(shoppingNotesRepositoryProvider);
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.55,
      minChildSize: 0.35,
      maxChildSize: 0.9,
      builder: (
        BuildContext context,
        ScrollController scrollController,
      ) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Text(
                l10n.shoppingNotesCategoriesSheetTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Expanded(
              child: categories.when(
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (Object e, StackTrace st) => Center(
                  child: SelectableText.rich(
                    TextSpan(
                      children: <InlineSpan>[
                        TextSpan(
                          text: l10n.shoppingNotesCouldNotLoadCategories,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(text: e.toString()),
                      ],
                    ),
                  ),
                ),
                data: (List<SpendingCategoryEntity> list) {
                  if (list.isEmpty) {
                    return Center(
                      child: Text(
                        l10n.shoppingNotesNoCategoriesYet,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    );
                  }
                  return ListView.separated(
                    controller: scrollController,
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (BuildContext context, int index) {
                      final SpendingCategoryEntity c = list[index];
                      return ListTile(
                        title: Text(c.name),
                        subtitle: Text(
                          l10n.shoppingNotesCategoryRowMeta(
                            c.id,
                            c.updatedAt.toIso8601String().substring(0, 10),
                          ),
                        ),
                        onTap: () => _promptEditCategory(context, repo, c),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () async {
                            final bool removed =
                                await repo.deleteCategoryIfUnused(c.id);
                            if (!context.mounted) {
                              return;
                            }
                            if (!removed) {
                              await _showCategoryInUseError(context);
                            }
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: FilledButton.icon(
                onPressed: () => _promptNewCategory(context, repo),
                icon: const Icon(Icons.add),
                label: Text(l10n.shoppingNotesAddCategory),
              ),
            ),
          ],
        );
      },
    );
  }

  static Future<void> _promptNewCategory(
    BuildContext context,
    ShoppingNotesRepository repo,
  ) async {
    final AppLocalizations l10n = context.l10n;
    final TextEditingController name = TextEditingController();
    final bool? save = await showDialog<bool>(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text(l10n.shoppingNotesNewCategory),
          content: TextField(
            controller: name,
            decoration: InputDecoration(
              labelText: l10n.settingsProfileNameLabel,
            ),
            textCapitalization: TextCapitalization.words,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(l10n.commonCancel),
            ),
            FilledButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: Text(l10n.commonSave),
            ),
          ],
        );
      },
    );
    if (save != true || !context.mounted) {
      return;
    }
    try {
      await repo.createCategory(name.text);
    } on Object catch (e) {
      if (context.mounted) {
        await _showCategoryError(context, e);
      }
    }
  }

  static Future<void> _promptEditCategory(
    BuildContext context,
    ShoppingNotesRepository repo,
    SpendingCategoryEntity existing,
  ) async {
    final AppLocalizations l10n = context.l10n;
    final TextEditingController name =
        TextEditingController(text: existing.name);
    final bool? save = await showDialog<bool>(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text(l10n.shoppingNotesRenameCategory),
          content: TextField(
            controller: name,
            decoration: InputDecoration(
              labelText: l10n.settingsProfileNameLabel,
            ),
            textCapitalization: TextCapitalization.words,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(l10n.commonCancel),
            ),
            FilledButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: Text(l10n.commonSave),
            ),
          ],
        );
      },
    );
    if (save != true || !context.mounted) {
      return;
    }
    try {
      await repo.updateCategory(
        SpendingCategoryEntity(
          id: existing.id,
          name: name.text,
          createdAt: existing.createdAt,
          updatedAt: existing.updatedAt,
        ),
      );
    } on Object catch (e) {
      if (context.mounted) {
        await _showCategoryError(context, e);
      }
    }
  }

  static Future<void> _showCategoryInUseError(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return showDialog<void>(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text(l10n.shoppingNotesCannotDelete),
          content: SelectableText.rich(
            TextSpan(
              children: <InlineSpan>[
                TextSpan(
                  text: l10n.shoppingNotesCannotDeleteBody,
                  style: TextStyle(
                    color: Theme.of(ctx).colorScheme.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FilledButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(l10n.commonOk),
            ),
          ],
        );
      },
    );
  }

  static Future<void> _showCategoryError(
    BuildContext context,
    Object error,
  ) {
    final AppLocalizations l10n = context.l10n;
    return showDialog<void>(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text(l10n.shoppingNotesCategoryError),
          content: SelectableText.rich(
            TextSpan(
              children: <InlineSpan>[
                TextSpan(
                  text: '$error',
                  style: TextStyle(
                    color: Theme.of(ctx).colorScheme.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FilledButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(l10n.commonOk),
            ),
          ],
        );
      },
    );
  }
}
