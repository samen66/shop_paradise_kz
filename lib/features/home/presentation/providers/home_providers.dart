import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_client.dart';
import '../../data/datasources/home_remote_data_source.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/repositories/home_repository.dart';
import '../../domain/usecases/get_home_sections_use_case.dart';
import '../../domain/usecases/get_just_for_you_page_use_case.dart';

final apiClientProvider = Provider<ApiClient>(
  (Ref ref) => ApiClient(),
);

final homeRemoteDataSourceProvider = Provider<HomeRemoteDataSource>(
  (Ref ref) => HomeRemoteDataSource(
    ref.watch(apiClientProvider),
  ),
);

final homeRepositoryProvider = Provider<HomeRepository>(
  (Ref ref) => HomeRepositoryImpl(
    ref.watch(homeRemoteDataSourceProvider),
  ),
);

final getHomeSectionsUseCaseProvider = Provider<GetHomeSectionsUseCase>(
  (Ref ref) => GetHomeSectionsUseCase(
    ref.watch(homeRepositoryProvider),
  ),
);

final getJustForYouPageUseCaseProvider = Provider<GetJustForYouPageUseCase>(
  (Ref ref) => GetJustForYouPageUseCase(
    ref.watch(homeRepositoryProvider),
  ),
);
