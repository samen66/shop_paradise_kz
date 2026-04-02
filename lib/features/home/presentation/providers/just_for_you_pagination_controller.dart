import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../category_filter/presentation/providers/applied_category_filter_notifier.dart';
import '../../domain/entities/home_entities.dart';
import 'home_providers.dart';

class JustForYouPaginationState {
  const JustForYouPaginationState({
    this.items = const <HomeItemEntity>[],
    this.isLoadingMore = false,
    this.hasMore = false,
    this.nextPage = 2,
    this.errorMessage,
  });

  final List<HomeItemEntity> items;
  final bool isLoadingMore;
  final bool hasMore;
  final int nextPage;
  final String? errorMessage;

  JustForYouPaginationState copyWith({
    List<HomeItemEntity>? items,
    bool? isLoadingMore,
    bool? hasMore,
    int? nextPage,
    String? errorMessage,
  }) => JustForYouPaginationState(
    items: items ?? this.items,
    isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    hasMore: hasMore ?? this.hasMore,
    nextPage: nextPage ?? this.nextPage,
    errorMessage: errorMessage,
  );
}

final justForYouPaginationControllerProvider =
    NotifierProvider<JustForYouPaginationController, JustForYouPaginationState>(
      JustForYouPaginationController.new,
    );

class JustForYouPaginationController
    extends Notifier<JustForYouPaginationState> {
  @override
  JustForYouPaginationState build() => const JustForYouPaginationState();

  void seed(HomeSectionEntity section) {
    if (state.items.isNotEmpty) {
      return;
    }
    final Set<String> applied = ref.read(appliedCategoryFilterProvider);
    if (applied.isEmpty) {
      state = state.copyWith(
        items: section.items,
        hasMore: section.hasMore,
        nextPage: section.nextPage,
        errorMessage: null,
      );
    } else {
      unawaited(refreshFromAppliedFilters());
    }
  }

  void resetAndSeed(HomeSectionEntity section) {
    final Set<String> applied = ref.read(appliedCategoryFilterProvider);
    if (applied.isEmpty) {
      state = JustForYouPaginationState(
        items: section.items,
        hasMore: section.hasMore,
        nextPage: section.nextPage,
      );
      return;
    }
    if (state.items.isNotEmpty) {
      return;
    }
    unawaited(refreshFromAppliedFilters());
  }

  /// Refetches page 1 using current [appliedCategoryFilterProvider] ids.
  Future<void> refreshFromAppliedFilters() async {
    final List<String> categoryIds =
        ref.read(appliedCategoryFilterProvider).toList()..sort();
    state = JustForYouPaginationState(
      items: const <HomeItemEntity>[],
      isLoadingMore: true,
      hasMore: false,
      nextPage: 2,
      errorMessage: null,
    );
    try {
      final HomeSectionEntity section = await ref
          .read(getJustForYouPageUseCaseProvider)
          .call(1, categoryIds: categoryIds);
      state = JustForYouPaginationState(
        items: section.items,
        hasMore: section.hasMore,
        nextPage: section.nextPage,
        isLoadingMore: false,
      );
    } catch (error) {
      state = JustForYouPaginationState(
        isLoadingMore: false,
        errorMessage: error.toString(),
      );
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) {
      return;
    }
    state = state.copyWith(isLoadingMore: true, errorMessage: null);
    final List<String> categoryIds =
        ref.read(appliedCategoryFilterProvider).toList()..sort();
    try {
      final HomeSectionEntity section = await ref
          .read(getJustForYouPageUseCaseProvider)
          .call(state.nextPage, categoryIds: categoryIds);
      state = state.copyWith(
        items: <HomeItemEntity>[...state.items, ...section.items],
        hasMore: section.hasMore,
        nextPage: section.nextPage,
        isLoadingMore: false,
      );
    } catch (err) {
      state = state.copyWith(
        isLoadingMore: false,
        errorMessage: err.toString(),
      );
    }
  }
}
