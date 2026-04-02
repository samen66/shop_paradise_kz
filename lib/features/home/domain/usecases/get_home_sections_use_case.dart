import '../entities/home_entities.dart';
import '../repositories/home_repository.dart';

class GetHomeSectionsUseCase {
  const GetHomeSectionsUseCase(this._repository);

  final HomeRepository _repository;

  Future<HomePageEntity> call() => _repository.getHomeSections();
}
