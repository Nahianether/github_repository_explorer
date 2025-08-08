import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:github_repository_explorer/core/error/failures.dart';
import 'package:github_repository_explorer/features/repository_search/domain/entities/search_result_entity.dart';
import 'package:github_repository_explorer/features/repository_search/domain/entities/repository_entity.dart';
import 'package:github_repository_explorer/features/repository_search/domain/entities/owner_entity.dart';
import 'package:github_repository_explorer/features/repository_search/domain/repositories/repository_repository.dart';
import 'package:github_repository_explorer/features/repository_search/domain/usecases/search_repositories.dart';

import 'search_repositories_test.mocks.dart';

@GenerateMocks([RepositoryRepository])
void main() {
  late SearchRepositoriesUseCase usecase;
  late MockRepositoryRepository mockRepositoryRepository;

  setUp(() {
    mockRepositoryRepository = MockRepositoryRepository();
    usecase = SearchRepositoriesUseCase(mockRepositoryRepository);
  });

  const tQuery = 'flutter';
  const tPage = 1;
  const tPerPage = 20;

  const tSearchRepositoriesParams = SearchRepositoriesParams(
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

  group('SearchRepositoriesUseCase', () {
    test('should get search result from the repository', () async {
      // arrange
      when(mockRepositoryRepository.searchRepositories(
        query: anyNamed('query'),
        page: anyNamed('page'),
        perPage: anyNamed('perPage'),
      )).thenAnswer((_) async => const Right(tSearchResultEntity));

      // act
      final result = await usecase(tSearchRepositoriesParams);

      // assert
      expect(result, const Right(tSearchResultEntity));
      verify(mockRepositoryRepository.searchRepositories(
        query: tQuery,
        page: tPage,
        perPage: tPerPage,
      ));
      verifyNoMoreInteractions(mockRepositoryRepository);
    });

    test('should return server failure when repository fails', () async {
      // arrange
      const tServerFailure = ServerFailure('Server error');
      when(mockRepositoryRepository.searchRepositories(
        query: anyNamed('query'),
        page: anyNamed('page'),
        perPage: anyNamed('perPage'),
      )).thenAnswer((_) async => const Left(tServerFailure));

      // act
      final result = await usecase(tSearchRepositoriesParams);

      // assert
      expect(result, const Left(tServerFailure));
      verify(mockRepositoryRepository.searchRepositories(
        query: tQuery,
        page: tPage,
        perPage: tPerPage,
      ));
      verifyNoMoreInteractions(mockRepositoryRepository);
    });

    test('should return network failure when network is unavailable', () async {
      // arrange
      const tNetworkFailure = NetworkFailure('No internet connection');
      when(mockRepositoryRepository.searchRepositories(
        query: anyNamed('query'),
        page: anyNamed('page'),
        perPage: anyNamed('perPage'),
      )).thenAnswer((_) async => const Left(tNetworkFailure));

      // act
      final result = await usecase(tSearchRepositoriesParams);

      // assert
      expect(result, const Left(tNetworkFailure));
      verify(mockRepositoryRepository.searchRepositories(
        query: tQuery,
        page: tPage,
        perPage: tPerPage,
      ));
      verifyNoMoreInteractions(mockRepositoryRepository);
    });

    test('should return cache failure when cache operation fails', () async {
      // arrange
      const tCacheFailure = CacheFailure('Cache error');
      when(mockRepositoryRepository.searchRepositories(
        query: anyNamed('query'),
        page: anyNamed('page'),
        perPage: anyNamed('perPage'),
      )).thenAnswer((_) async => const Left(tCacheFailure));

      // act
      final result = await usecase(tSearchRepositoriesParams);

      // assert
      expect(result, const Left(tCacheFailure));
    });

    group('SearchRepositoriesParams', () {
      test('should create params with correct values', () {
        // arrange & act
        const params = SearchRepositoriesParams(
          query: 'test_query',
          page: 5,
          perPage: 50,
        );

        // assert
        expect(params.query, 'test_query');
        expect(params.page, 5);
        expect(params.perPage, 50);
      });

      test('should handle edge case parameters', () {
        // arrange & act
        const params = SearchRepositoriesParams(
          query: '',
          page: 0,
          perPage: 1,
        );

        // assert
        expect(params.query, '');
        expect(params.page, 0);
        expect(params.perPage, 1);
      });
    });
  });
}