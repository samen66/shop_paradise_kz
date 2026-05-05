import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/shopping_note_entity.dart';
import '../../domain/entities/spending_category_entity.dart';
import '../../domain/repositories/shopping_notes_repository.dart';
import '../providers/shopping_notes_providers.dart';
import '../widgets/shopping_category_manager_sheet.dart';

/// Offline-first CRUD for local shopping / price notes (Drift) with filters.
class ShoppingNotesPage extends ConsumerStatefulWidget {
  const ShoppingNotesPage({super.key});

  @override
  ConsumerState<ShoppingNotesPage> createState() => _ShoppingNotesPageState();
}

class _ShoppingNotesPageState extends ConsumerState<ShoppingNotesPage> {
  final TextEditingController _searchQuery = TextEditingController();
  int? _filterCategoryId;

  @override
  void dispose() {
    _searchQuery.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<bool> online = ref.watch(connectivityStreamProvider);
    final AsyncValue<List<ShoppingNoteEntity>> notes =
        ref.watch(shoppingNotesStreamProvider);
    final AsyncValue<List<SpendingCategoryEntity>> categories =
        ref.watch(spendingCategoriesStreamProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
        title: const Text('Shopping notes'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.category_outlined),
            tooltip: 'Manage categories',
            onPressed: () => ShoppingCategoryManagerSheet.show(context),
          ),
          TextButton(
            onPressed: () => context.push('/analytics'),
            child: const Text('Chart'),
          ),
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.deferToChild,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: online.when(
                data: (bool isOn) => Text(
                  isOn
                      ? 'Online: changes will try to sync (demo HTTP).'
                      : 'Offline: data stays on this device.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: TextField(
                controller: _searchQuery,
                decoration: const InputDecoration(
                  hintText: 'Filter by title, details, or category',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                textInputAction: TextInputAction.search,
                onChanged: (_) => setState(() {}),
              ),
            ),
            categories.when(
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
              data: (List<SpendingCategoryEntity> cats) {
                if (cats.isEmpty) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: FilterChip(
                            label: const Text('All categories'),
                            selected: _filterCategoryId == null,
                            onSelected: (_) {
                              setState(() => _filterCategoryId = null);
                            },
                          ),
                        ),
                        ...cats.map((SpendingCategoryEntity c) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: FilterChip(
                              label: Text(c.name),
                              selected: _filterCategoryId == c.id,
                              onSelected: (_) {
                                setState(() => _filterCategoryId = c.id);
                              },
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                );
              },
            ),
            Expanded(
              child: notes.when(
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (Object e, StackTrace st) => Center(
                  child: SelectableText.rich(
                    TextSpan(
                      children: <InlineSpan>[
                        const TextSpan(
                          text: 'Could not load notes.\n',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(text: e.toString()),
                      ],
                    ),
                  ),
                ),
                data: (List<ShoppingNoteEntity> list) {
                  final List<ShoppingNoteEntity> filtered =
                      _filterNotes(list);
                  if (list.isEmpty) {
                    return Center(
                      child: Text(
                        'No notes yet. Tap + to add one.',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    );
                  }
                  if (filtered.isEmpty) {
                    return Center(
                      child: Text(
                        'No notes match the current filter.',
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  return ListView.separated(
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (BuildContext context, int index) {
                      final ShoppingNoteEntity n = filtered[index];
                      return ListTile(
                        title: Text(n.title),
                        subtitle: Text(
                          '${n.category} · ${n.amount.toStringAsFixed(2)} · '
                          '${n.syncedToRemote ? 'synced' : 'local'}',
                        ),
                        isThreeLine: true,
                        onTap: () => _openEditor(context, ref, n),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () async {
                            await ref
                                .read(shoppingNotesRepositoryProvider)
                                .deleteNote(n.id);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openEditor(context, ref, null),
        child: const Icon(Icons.add),
      ),
    );
  }

  List<ShoppingNoteEntity> _filterNotes(List<ShoppingNoteEntity> all) {
    final String q = _searchQuery.text.trim().toLowerCase();
    return all.where((ShoppingNoteEntity n) {
      if (_filterCategoryId != null && n.categoryId != _filterCategoryId) {
        return false;
      }
      if (q.isEmpty) {
        return true;
      }
      return n.title.toLowerCase().contains(q) ||
          n.body.toLowerCase().contains(q) ||
          n.category.toLowerCase().contains(q);
    }).toList(growable: false);
  }

  Future<void> _openEditor(
    BuildContext context,
    WidgetRef ref,
    ShoppingNoteEntity? existing,
  ) async {
    final ShoppingNotesRepository repo =
        ref.read(shoppingNotesRepositoryProvider);
    final List<SpendingCategoryEntity> categories =
        await repo.getCategories();
    if (!context.mounted) {
      return;
    }
    if (categories.isEmpty) {
      await showDialog<void>(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Add a category first'),
            content: const Text(
              'Notes require a category. Open “Manage categories” '
              'and create at least one.',
            ),
            actions: <Widget>[
              FilledButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }
    final TextEditingController title = TextEditingController(
      text: existing?.title ?? '',
    );
    final TextEditingController body = TextEditingController(
      text: existing?.body ?? '',
    );
    final TextEditingController amount = TextEditingController(
      text: existing == null ? '0' : existing.amount.toString(),
    );
    int selectedCategoryId =
        _resolveCategoryId(existing, categories) ?? categories.first.id;
    final bool? saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext ctx) {
        return StatefulBuilder(
          builder: (BuildContext ctx, void Function(void Function()) setSt) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.viewInsetsOf(ctx).bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    existing == null ? 'New note' : 'Edit note',
                    style: Theme.of(ctx).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: title,
                    decoration: const InputDecoration(labelText: 'Title'),
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  TextField(
                    controller: body,
                    decoration: const InputDecoration(labelText: 'Details'),
                    maxLines: 3,
                  ),
                  DropdownButtonFormField<int>(
                    // ignore: deprecated_member_use
                    value: selectedCategoryId,
                    decoration: const InputDecoration(
                      labelText: 'Category',
                    ),
                    items: categories
                        .map(
                          (SpendingCategoryEntity c) =>
                              DropdownMenuItem<int>(
                            value: c.id,
                            child: Text(c.name),
                          ),
                        )
                        .toList(growable: false),
                    onChanged: (int? v) {
                      if (v == null) {
                        return;
                      }
                      setSt(() => selectedCategoryId = v);
                    },
                  ),
                  TextField(
                    controller: amount,
                    decoration: const InputDecoration(labelText: 'Amount'),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () => Navigator.of(ctx).pop(true),
                    child: const Text('Save'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
    if (saved != true || !context.mounted) {
      return;
    }
    final double? parsed = double.tryParse(amount.text.replaceAll(',', '.'));
    if (existing == null) {
      await repo.createNote(
        title: title.text,
        body: body.text,
        categoryId: selectedCategoryId,
        amount: parsed ?? 0,
      );
    } else {
      final SpendingCategoryEntity cat = categories.firstWhere(
        (SpendingCategoryEntity c) => c.id == selectedCategoryId,
      );
      await repo.updateNote(
        ShoppingNoteEntity(
          id: existing.id,
          title: title.text,
          body: body.text,
          category: cat.name,
          categoryId: selectedCategoryId,
          amount: parsed ?? existing.amount,
          syncedToRemote: existing.syncedToRemote,
          createdAt: existing.createdAt,
          updatedAt: existing.updatedAt,
        ),
      );
    }
  }

  int? _resolveCategoryId(
    ShoppingNoteEntity? existing,
    List<SpendingCategoryEntity> categories,
  ) {
    if (categories.isEmpty) {
      return null;
    }
    if (existing?.categoryId != null) {
      final int id = existing!.categoryId!;
      final bool exists = categories.any(
        (SpendingCategoryEntity c) => c.id == id,
      );
      if (exists) {
        return id;
      }
    }
    if (existing != null) {
      for (final SpendingCategoryEntity c in categories) {
        if (c.name.toLowerCase() == existing.category.toLowerCase()) {
          return c.id;
        }
      }
    }
    return categories.first.id;
  }
}
