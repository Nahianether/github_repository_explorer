import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/search_result_entity.dart';
import '../../domain/repositories/repository_repository.dart';
import '../datasources/remote/repository_remote_data_source.dart';
import '../datasources/local/repository_local_data_source.dart';

class RepositoryRepositoryImpl implements RepositoryRepository {
  final RepositoryRemoteDataSource remoteDataSource;
  final RepositoryLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  RepositoryRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, SearchResultEntity>> searchRepositories({
    required String query,
    required int page,
    required int perPage,
  }) async {
    try {
      final localSearchResult = await localDataSource.getCachedSearchResult(query, page);
      if (localSearchResult != null) {
        debugPrint('Returning cached data for query: $query, page: $page');
        return Right(localSearchResult);
      }
    } catch (e) {
      debugPrint('Cache read error: $e');
    }

    if (await networkInfo.isConnected) {
      try {
        debugPrint('Fetching fresh data from API for query: $query, page: $page');
        final remoteSearchResult = await remoteDataSource.searchRepositories(
          query,
          'stars',
          'desc',
          page,
          perPage,
        );

        await localDataSource.cacheSearchResult(query, page, remoteSearchResult);
        debugPrint('Cached fresh data for query: $query, page: $page');

        return Right(remoteSearchResult);
      } catch (e) {
        if (e.toString().contains('API rate limit exceeded')) {
          return const Left(ServerFailure('API rate limit exceeded'));
        }
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(ServerFailure('No internet connection and no cached data available'));
    }
  }

  @override
  Future<Either<Failure, SearchResultEntity>> refreshRepositories({
    required String query,
    required int page,
    required int perPage,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        debugPrint('Refreshing data from API for query: $query, page: $page');
        final remoteSearchResult = await remoteDataSource.searchRepositories(
          query,
          'stars',
          'desc',
          page,
          perPage,
        );

        await localDataSource.cacheSearchResult(query, page, remoteSearchResult);
        debugPrint('Updated cache with fresh data for query: $query, page: $page');

        return Right(remoteSearchResult);
      } catch (e) {
        if (e.toString().contains('API rate limit exceeded')) {
          return const Left(ServerFailure('API rate limit exceeded'));
        }
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(ServerFailure('No internet connection for refresh'));
    }
  }
}
