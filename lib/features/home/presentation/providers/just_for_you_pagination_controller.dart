import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  }) =>
      JustForYouPaginationState(
        items: items ?? this.items,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        hasMore: hasMore ?? this.hasMore,
        nextPage: nextPage ?? this.nextPage,
        errorMessage: errorMessage,
      );
}

final justForYouPaginationControllerProvider = NotifierProvider<
    JustForYouPaginationController, JustForYouPaginationState>(
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
    state = state.copyWith(
      items: section.items,
      hasMore: section.hasMore,
      nextPage: section.nextPage,
      errorMessage: null,
    );
  }

  void resetAndSeed(HomeSectionEntity section) {
    state = JustForYouPaginationState(
      items: section.items,
      hasMore: section.hasMore,
      nextPage: section.nextPage,
    );
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) {
      return;
    }
    state = state.copyWith(isLoadingMore: true, errorMessage: null);
    try {
      final HomeSectionEntity section = await ref
          .read(getJustForYouPageUseCaseProvider)
          .call(state.nextPage);
      state = state.copyWith(
        items: <HomeItemEntity>[
          ...state.items,
          ...section.items,
        ],
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
