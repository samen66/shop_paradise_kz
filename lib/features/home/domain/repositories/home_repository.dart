import '../entities/home_entities.dart';

abstract class HomeRepository {
  Future<HomePageEntity> getHomeSections();

  /// [categoryIds]: when non-empty, API returns items matching any id (OR).
  Future<HomeSectionEntity> getJustForYouPage(
    int page, {
    List<String> categoryIds = const <String>[],
  });
}
