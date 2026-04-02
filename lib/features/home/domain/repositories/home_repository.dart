import '../entities/home_entities.dart';

abstract class HomeRepository {
  Future<HomePageEntity> getHomeSections();
  Future<HomeSectionEntity> getJustForYouPage(int page);
}
