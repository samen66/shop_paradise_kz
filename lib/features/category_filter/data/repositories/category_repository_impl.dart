import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/category_filter_entities.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/category_remote_data_source.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  const CategoryRepositoryImpl(this._remoteDataSource);

  final CategoryRemoteDataSource _remoteDataSource;

  @override
  Future<List<CategoryNodeEntity>> getCategoryTree() async {
    try {
      final models = await _remoteDataSource.fetchCategoryTree();
      return models.map((m) => m.toEntity()).toList(growable: false);
    } on DioException catch (err) {
      throw mapDioExceptionToFailure(err);
    } on FormatException {
      throw const ParsingFailure();
    } catch (_) {
      throw const ServerFailure();
    }
  }
}
