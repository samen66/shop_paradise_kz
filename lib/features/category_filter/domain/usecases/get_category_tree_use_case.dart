import '../entities/category_filter_entities.dart';
import '../repositories/category_repository.dart';

class GetCategoryTreeUseCase {
  const GetCategoryTreeUseCase(this._repository);

  final CategoryRepository _repository;

  Future<List<CategoryNodeEntity>> call() => _repository.getCategoryTree();
}
