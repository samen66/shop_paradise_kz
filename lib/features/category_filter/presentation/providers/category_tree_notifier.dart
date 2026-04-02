import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/category_filter_entities.dart';
import 'category_filter_dependencies.dart';

final categoryTreeProvider =
    AsyncNotifierProvider<CategoryTreeNotifier, List<CategoryNodeEntity>>(
      CategoryTreeNotifier.new,
    );

class CategoryTreeNotifier extends AsyncNotifier<List<CategoryNodeEntity>> {
  @override
  Future<List<CategoryNodeEntity>> build() async {
    return ref.read(getCategoryTreeUseCaseProvider).call();
  }

  Future<void> reload() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(getCategoryTreeUseCaseProvider).call(),
    );
  }
}
