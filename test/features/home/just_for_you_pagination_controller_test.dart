import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shop_paradise_kz/features/home/domain/entities/home_entities.dart';
import 'package:shop_paradise_kz/features/home/domain/repositories/home_repository.dart';
import 'package:shop_paradise_kz/features/home/domain/usecases/get_just_for_you_page_use_case.dart';
import 'package:shop_paradise_kz/features/home/presentation/providers/home_providers.dart';
import 'package:shop_paradise_kz/features/home/presentation/providers/just_for_you_pagination_controller.dart';

void main() {
  test('Pagination appends new page items', () async {
    final ProviderContainer container = ProviderContainer(
      overrides: <Override>[
        getJustForYouPageUseCaseProvider.overrideWithValue(
          _FakeGetJustForYouPageUseCase(),
        ),
      ],
    );
    addTearDown(container.dispose);

    final HomeSectionEntity seedSection = HomeSectionEntity(
      type: HomeSectionType.justForYou,
      title: 'Just For You',
      layout: HomeSectionLayout.grid2,
      items: const <HomeItemEntity>[
        HomeItemEntity(id: '1', title: 'A', imageUrl: 'x'),
      ],
      hasMore: true,
      nextPage: 2,
    );

    container
        .read(justForYouPaginationControllerProvider.notifier)
        .seed(seedSection);
    await container
        .read(justForYouPaginationControllerProvider.notifier)
        .loadMore();

    final JustForYouPaginationState state = container.read(
      justForYouPaginationControllerProvider,
    );
    expect(state.items.length, 2);
    expect(state.hasMore, false);
  });
}

class _FakeGetJustForYouPageUseCase extends GetJustForYouPageUseCase {
  _FakeGetJustForYouPageUseCase() : super(_FakeHomeRepository());

  @override
  Future<HomeSectionEntity> call(
    int page, {
    List<String> categoryIds = const <String>[],
  }) async {
    return const HomeSectionEntity(
      type: HomeSectionType.justForYou,
      title: 'Just For You',
      layout: HomeSectionLayout.grid2,
      items: <HomeItemEntity>[
        HomeItemEntity(id: '2', title: 'B', imageUrl: 'x'),
      ],
      hasMore: false,
      nextPage: 3,
    );
  }
}

class _FakeHomeRepository implements HomeRepository {
  @override
  Future<HomePageEntity> getHomeSections() async =>
      const HomePageEntity(sections: <HomeSectionEntity>[]);

  @override
  Future<HomeSectionEntity> getJustForYouPage(
    int page, {
    List<String> categoryIds = const <String>[],
  }) async {
    throw UnimplementedError();
  }
}
