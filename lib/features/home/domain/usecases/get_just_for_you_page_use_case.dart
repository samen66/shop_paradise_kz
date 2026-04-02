import '../entities/home_entities.dart';
import '../repositories/home_repository.dart';

class GetJustForYouPageUseCase {
  const GetJustForYouPageUseCase(this._repository);

  final HomeRepository _repository;

  Future<HomeSectionEntity> call(int page) =>
      _repository.getJustForYouPage(page);
}
