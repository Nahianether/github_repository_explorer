import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:github_repository_explorer/core/error/failures.dart';
import 'package:github_repository_explorer/features/repository_search/domain/entities/search_result_entity.dart';
import 'package:github_repository_explorer/features/repository_search/domain/entities/repository_entity.dart';
import 'package:github_repository_explorer/features/repository_search/domain/entities/owner_entity.dart';
import 'package:github_repository_explorer/features/repository_search/domain/usecases/refresh_repositories.dart';

import '../usecases/search_repositories_test.mocks.dart';

void main() {
  late RefreshRepositoriesUseCase usecase;
  late MockRepositoryRepository mockRepositoryRepository;

  setUp(() {
    mockRepositoryRepository = MockRepositoryRepository();
    usecase = RefreshRepositoriesUseCase(mockRepositoryRepository);
  });

  const tQuery = 'flutter';
  const tPage = 1;
  const tPerPage = 20;

  const tRefreshRepositoriesParams = RefreshRepositoriesParams(
    query: tQuery,
    page: tPage,
    perPage: tPerPage,
  );

  const tOwnerEntity = OwnerEntity(
    id: 1,
    login: 'test_user',
    avatarUrl: 'https://example.com/avatar.png',
  );

  const tRepositoryEntity = RepositoryEntity(
    id: 1,
    name: 'test_repo',
    fullName: 'test_user/test_repo',
    description: 'A test repository',
    stargazersCount: 100,
    forksCount: 50,
    htmlUrl: 'https://github.com/test_user/test_repo',
    owner: tOwnerEntity,
  );

  const tSearchResultEntity = SearchResultEntity(
    totalCount: 1,
    incompleteResults: false,
    items: [tRepositoryEntity],
  );

  group('RefreshRepositoriesUseCase', () {
    test('should get refreshed search result from the repository', () async {
      // arrange
      when(mockRepositoryRepository.refreshRepositories(
        query: anyNamed('query'),
        page: anyNamed('page'),
        perPage: anyNamed('perPage'),
      )).thenAnswer((_) async => const Right(tSearchResultEntity));

      // act
      final result = await usecase(tRefreshRepositoriesParams);

      // assert
      expect(result, const Right(tSearchResultEntity));
      verify(mockRepositoryRepository.refreshRepositories(
        query: tQuery,
        page: tPage,
        perPage: tPerPage,
      ));
      verifyNoMoreInteractions(mockRepositoryRepository);
    });

    test('should return server failure when repository refresh fails', () async {
      // arrange
      const tServerFailure = ServerFailure('Server error');
      when(mockRepositoryRepository.refreshRepositories(
        query: anyNamed('query'),
        page: anyNamed('page'),
        perPage: anyNamed('perPage'),
      )).thenAnswer((_) async => const Left(tServerFailure));

      // act
      final result = await usecase(tRefreshRepositoriesParams);

      // assert
      expect(result, const Left(tServerFailure));
      verify(mockRepositoryRepository.refreshRepositories(
        query: tQuery,
        page: tPage,
        perPage: tPerPage,
      ));
      verifyNoMoreInteractions(mockRepositoryRepository);
    });

    test('should return network failure when network is unavailable during refresh', () async {
      // arrange
      const tNetworkFailure = NetworkFailure('No internet connection');
      when(mockRepositoryRepository.refreshRepositories(
        query: anyNamed('query'),
        page: anyNamed('page'),
        perPage: anyNamed('perPage'),
      )).thenAnswer((_) async => const Left(tNetworkFailure));

      // act
      final result = await usecase(tRefreshRepositoriesParams);

      // assert
      expect(result, const Left(tNetworkFailure));
      verify(mockRepositoryRepository.refreshRepositories(
        query: tQuery,
        page: tPage,
        perPage: tPerPage,
      ));
      verifyNoMoreInteractions(mockRepositoryRepository);
    });

    group('RefreshRepositoriesParams', () {
      test('should create params with correct values', () {
        // arrange & act
        const params = RefreshRepositoriesParams(
          query: 'test_query',
          page: 5,
          perPage: 50,
        );

        // assert
        expect(params.query, 'test_query');
        expect(params.page, 5);
        expect(params.perPage, 50);
      });

      test('should handle edge case parameters for refresh', () {
        // arrange & act
        const params = RefreshRepositoriesParams(
          query: '',
          page: 1,
          perPage: 1,
        );

        // assert
        expect(params.query, '');
        expect(params.page, 1);
        expect(params.perPage, 1);
      });
    });
  });
}