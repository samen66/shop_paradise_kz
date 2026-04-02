import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/home_entities.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl(this._remoteDataSource);

  final HomeRemoteDataSource _remoteDataSource;

  @override
  Future<HomePageEntity> getHomeSections() async {
    try {
      final response = await _remoteDataSource.fetchHomeSections();
      return response.toEntity();
    } on DioException catch (err) {
      throw mapDioExceptionToFailure(err);
    } on FormatException {
      throw const ParsingFailure();
    } catch (_) {
      throw const ServerFailure();
    }
  }

  @override
  Future<HomeSectionEntity> getJustForYouPage(
    int page, {
    List<String> categoryIds = const <String>[],
  }) async {
    try {
      final section = await _remoteDataSource.fetchJustForYouPage(
        page,
        categoryIds: categoryIds,
      );
      return section.toEntity();
    } on DioException catch (err) {
      throw mapDioExceptionToFailure(err);
    } on FormatException {
      throw const ParsingFailure();
    } catch (_) {
      throw const ServerFailure();
    }
  }
}
