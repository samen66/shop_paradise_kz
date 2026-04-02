import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/home_entities.dart';
import 'home_providers.dart';

final homeControllerProvider =
    AsyncNotifierProvider<HomeController, HomePageEntity>(HomeController.new);

class HomeController extends AsyncNotifier<HomePageEntity> {
  @override
  Future<HomePageEntity> build() async {
    return ref.read(getHomeSectionsUseCaseProvider).call();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(getHomeSectionsUseCaseProvider).call(),
    );
  }
}
