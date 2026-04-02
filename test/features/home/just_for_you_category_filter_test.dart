import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_paradise_kz/features/category_filter/presentation/providers/applied_category_filter_notifier.dart';
import 'package:shop_paradise_kz/features/home/domain/entities/home_entities.dart';
import 'package:shop_paradise_kz/features/home/domain/repositories/home_repository.dart';
import 'package:shop_paradise_kz/features/home/presentation/providers/home_providers.dart';
import 'package:shop_paradise_kz/features/home/presentation/providers/just_for_you_pagination_controller.dart';

class _FakeHomeRepository implements HomeRepository {
  _FakeHomeRepository(this._section);

  final HomeSectionEntity _section;
  int lastJfyPage = 0;
  List<String> lastJfyCategoryIds = const <String>[];

  @override
  Future<HomePageEntity> getHomeSections() async {
    throw UnimplementedError();
  }

  @override
  Future<HomeSectionEntity> getJustForYouPage(
    int page, {
    List<String> categoryIds = const <String>[],
  }) async {
    lastJfyPage = page;
    lastJfyCategoryIds = List<String>.from(categoryIds);
    return _section;
  }
}

void main() {
  group('JustForYouPaginationController', () {
    test(
      'should pass sorted category ids when refreshFromAppliedFilters runs',
      () async {
        const HomeSectionEntity section = HomeSectionEntity(
          type: HomeSectionType.justForYou,
          title: 'Just For You',
          layout: HomeSectionLayout.grid2,
          items: <HomeItemEntity>[],
          hasMore: false,
          nextPage: 2,
        );
        final _FakeHomeRepository fake = _FakeHomeRepository(section);
        final ProviderContainer container = ProviderContainer(
          overrides: <Override>[homeRepositoryProvider.overrideWithValue(fake)],
        );
        addTearDown(container.dispose);
        container.read(appliedCategoryFilterProvider.notifier).setAll(<String>{
          'zebra',
          'apple',
        });
        await container
            .read(justForYouPaginationControllerProvider.notifier)
            .refreshFromAppliedFilters();
        expect(fake.lastJfyPage, 1);
        expect(fake.lastJfyCategoryIds, <String>['apple', 'zebra']);
      },
    );
  });
}
