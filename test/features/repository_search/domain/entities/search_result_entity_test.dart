import 'package:flutter_test/flutter_test.dart';
import 'package:github_repository_explorer/features/repository_search/domain/entities/search_result_entity.dart';
import 'package:github_repository_explorer/features/repository_search/domain/entities/repository_entity.dart';
import 'package:github_repository_explorer/features/repository_search/domain/entities/owner_entity.dart';

void main() {
  group('SearchResultEntity', () {
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

    test('should be a subclass of Equatable', () {
      // arrange & act & assert
      expect(tSearchResultEntity, isA<SearchResultEntity>());
    });

    test('should have correct props for equality comparison', () {
      // arrange & act
      final props = tSearchResultEntity.props;

      // assert
      expect(props, [1, false, [tRepositoryEntity]]);
    });

    test('should be equal when all properties are the same', () {
      // arrange
      const tSearchResultEntity1 = SearchResultEntity(
        totalCount: 1,
        incompleteResults: false,
        items: [tRepositoryEntity],
      );
      const tSearchResultEntity2 = SearchResultEntity(
        totalCount: 1,
        incompleteResults: false,
        items: [tRepositoryEntity],
      );

      // act & assert
      expect(tSearchResultEntity1, equals(tSearchResultEntity2));
    });

    test('should handle empty items list', () {
      // arrange
      const tEmptySearchResult = SearchResultEntity(
        totalCount: 0,
        incompleteResults: false,
        items: [],
      );

      // act & assert
      expect(tEmptySearchResult.items, isEmpty);
      expect(tEmptySearchResult.totalCount, equals(0));
    });

    test('should handle multiple items in list', () {
      // arrange
      const tRepositoryEntity2 = RepositoryEntity(
        id: 2,
        name: 'another_repo',
        fullName: 'test_user/another_repo',
        description: 'Another test repository',
        stargazersCount: 200,
        forksCount: 75,
        htmlUrl: 'https://github.com/test_user/another_repo',
        owner: tOwnerEntity,
      );

      const tMultipleItemsSearchResult = SearchResultEntity(
        totalCount: 2,
        incompleteResults: false,
        items: [tRepositoryEntity, tRepositoryEntity2],
      );

      // act & assert
      expect(tMultipleItemsSearchResult.items.length, equals(2));
      expect(tMultipleItemsSearchResult.totalCount, equals(2));
      expect(tMultipleItemsSearchResult.items[0], equals(tRepositoryEntity));
      expect(tMultipleItemsSearchResult.items[1], equals(tRepositoryEntity2));
    });

    test('should handle incomplete results flag', () {
      // arrange
      const tIncompleteSearchResult = SearchResultEntity(
        totalCount: 1000,
        incompleteResults: true,
        items: [tRepositoryEntity],
      );

      // act & assert
      expect(tIncompleteSearchResult.incompleteResults, isTrue);
      expect(tIncompleteSearchResult.totalCount, equals(1000));
    });

    test('should not be equal when properties are different', () {
      // arrange
      const tSearchResultEntity1 = SearchResultEntity(
        totalCount: 1,
        incompleteResults: false,
        items: [tRepositoryEntity],
      );
      const tSearchResultEntity2 = SearchResultEntity(
        totalCount: 2,
        incompleteResults: true,
        items: [],
      );

      // act & assert
      expect(tSearchResultEntity1, isNot(equals(tSearchResultEntity2)));
    });

    test('should have consistent hashCode for equal objects', () {
      // arrange
      const tSearchResultEntity1 = SearchResultEntity(
        totalCount: 1,
        incompleteResults: false,
        items: [tRepositoryEntity],
      );
      const tSearchResultEntity2 = SearchResultEntity(
        totalCount: 1,
        incompleteResults: false,
        items: [tRepositoryEntity],
      );

      // act & assert
      expect(tSearchResultEntity1.hashCode, equals(tSearchResultEntity2.hashCode));
    });
  });
}