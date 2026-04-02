import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../home/presentation/providers/home_providers.dart';
import '../../data/datasources/category_remote_data_source.dart';
import '../../data/repositories/category_repository_impl.dart';
import '../../domain/repositories/category_repository.dart';
import '../../domain/usecases/get_category_tree_use_case.dart';

final categoryRemoteDataSourceProvider = Provider<CategoryRemoteDataSource>(
  (Ref ref) => CategoryRemoteDataSource(ref.watch(apiClientProvider)),
);

final categoryRepositoryProvider = Provider<CategoryRepository>(
  (Ref ref) =>
      CategoryRepositoryImpl(ref.watch(categoryRemoteDataSourceProvider)),
);

final getCategoryTreeUseCaseProvider = Provider<GetCategoryTreeUseCase>(
  (Ref ref) => GetCategoryTreeUseCase(ref.watch(categoryRepositoryProvider)),
);
