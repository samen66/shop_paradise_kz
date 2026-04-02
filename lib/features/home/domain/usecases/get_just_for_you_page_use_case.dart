import '../entities/home_entities.dart';
import '../repositories/home_repository.dart';

class GetJustForYouPageUseCase {
  const GetJustForYouPageUseCase(this._repository);

  final HomeRepository _repository;

  Future<HomeSectionEntity> call(
    int page, {
    List<String> categoryIds = const <String>[],
  }) => _repository.getJustForYouPage(page, categoryIds: categoryIds);
}
