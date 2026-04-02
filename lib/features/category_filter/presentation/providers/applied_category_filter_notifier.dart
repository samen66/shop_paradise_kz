import 'package:flutter_riverpod/flutter_riverpod.dart';

final appliedCategoryFilterProvider =
    NotifierProvider<AppliedCategoryFilterNotifier, Set<String>>(
      AppliedCategoryFilterNotifier.new,
    );

class AppliedCategoryFilterNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() => <String>{};

  void setAll(Set<String> ids) {
    state = Set<String>.from(ids);
  }

  void clearAll() {
    state = <String>{};
  }
}
