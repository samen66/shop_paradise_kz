import '../entities/category_filter_entities.dart';

abstract class CategoryRepository {
  Future<List<CategoryNodeEntity>> getCategoryTree();
}
