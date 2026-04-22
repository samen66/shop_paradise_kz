import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/home_entities.dart';
import '../../../product_details/presentation/pages/product_details_page.dart';
import '../providers/home_controller.dart';
import '../providers/just_for_you_pagination_controller.dart';
import '../widgets/home_error_state.dart';
import '../widgets/home_loading_skeleton.dart';
import '../widgets/home_section_renderer.dart';
import '../widgets/search_bar_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }
    final double remaining =
        _scrollController.position.maxScrollExtent - _scrollController.offset;
    if (remaining < 500) {
      ref.read(justForYouPaginationControllerProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<HomePageEntity> homeState = ref.watch(
      homeControllerProvider,
    );
    return homeState.when(
      loading: () => const HomeLoadingSkeleton(),
      error: (Object err, StackTrace stack) => HomeErrorState(
        message: err.toString(),
        onRetry: () => ref.read(homeControllerProvider.notifier).refresh(),
      ),
      data: (HomePageEntity homePage) {
        final HomeSectionEntity? justForYouSection = homePage.sections
            .cast<HomeSectionEntity?>()
            .firstWhere(
              (HomeSectionEntity? section) =>
                  section?.type.isJustForYou ?? false,
              orElse: () => null,
            );
        if (justForYouSection != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ref
                .read(justForYouPaginationControllerProvider.notifier)
                .resetAndSeed(justForYouSection);
          });
        }
        return RefreshIndicator(
          onRefresh: () async {
            await ref.read(homeControllerProvider.notifier).refresh();
          },
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.only(bottom: 24),
            itemCount: homePage.sections.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return const SearchBarWidget();
              }
              final HomeSectionEntity section = homePage.sections[index - 1];
              return HomeSectionRenderer(
                section: section,
                onProductTap: (HomeItemEntity item) {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => ProductDetailsPage(item: item),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
