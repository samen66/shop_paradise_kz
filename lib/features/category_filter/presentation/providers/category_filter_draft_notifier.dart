import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'applied_category_filter_notifier.dart';

final categoryFilterDraftProvider =
    NotifierProvider<CategoryFilterDraftNotifier, Set<String>>(
      CategoryFilterDraftNotifier.new,
    );

class CategoryFilterDraftNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() => <String>{};

  void initFromApplied() {
    state = Set<String>.from(ref.read(appliedCategoryFilterProvider));
  }

  void toggle(String id) {
    final Set<String> next = Set<String>.from(state);
    if (next.contains(id)) {
      next.remove(id);
    } else {
      next.add(id);
    }
    state = next;
  }

  void setAll(Set<String> ids) {
    state = Set<String>.from(ids);
  }

  void clearDraft() {
    state = <String>{};
  }
}
