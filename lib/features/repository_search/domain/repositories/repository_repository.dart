import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/search_result_entity.dart';

abstract class RepositoryRepository {
  Future<Either<Failure, SearchResultEntity>> searchRepositories({
    required String query,
    required int page,
    required int perPage,
  });

  Future<Either<Failure, SearchResultEntity>> refreshRepositories({
    required String query,
    required int page,
    required int perPage,
  });

  Future<Either<Failure, SearchResultEntity>> getCachedRepositories();
}