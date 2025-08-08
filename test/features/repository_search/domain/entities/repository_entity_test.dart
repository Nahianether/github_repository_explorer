import 'package:flutter_test/flutter_test.dart';
import 'package:github_repository_explorer/features/repository_search/domain/entities/repository_entity.dart';
import 'package:github_repository_explorer/features/repository_search/domain/entities/owner_entity.dart';

void main() {
  group('RepositoryEntity', () {
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

    test('should be a subclass of Equatable', () {
      // arrange & act & assert
      expect(tRepositoryEntity, isA<RepositoryEntity>());
    });

    test('should have correct props for equality comparison', () {
      // arrange & act
      final props = tRepositoryEntity.props;

      // assert
      expect(props, [
        1,
        'test_repo',
        'test_user/test_repo',
        'A test repository',
        100,
        50,
        'https://github.com/test_user/test_repo',
        tOwnerEntity,
      ]);
    });

    test('should be equal when all properties are the same', () {
      // arrange
      const tRepositoryEntity1 = RepositoryEntity(
        id: 1,
        name: 'test_repo',
        fullName: 'test_user/test_repo',
        description: 'A test repository',
        stargazersCount: 100,
        forksCount: 50,
        htmlUrl: 'https://github.com/test_user/test_repo',
        owner: tOwnerEntity,
      );
      const tRepositoryEntity2 = RepositoryEntity(
        id: 1,
        name: 'test_repo',
        fullName: 'test_user/test_repo',
        description: 'A test repository',
        stargazersCount: 100,
        forksCount: 50,
        htmlUrl: 'https://github.com/test_user/test_repo',
        owner: tOwnerEntity,
      );

      // act & assert
      expect(tRepositoryEntity1, equals(tRepositoryEntity2));
    });

    test('should handle null description correctly', () {
      // arrange
      const tRepositoryEntityWithNullDescription = RepositoryEntity(
        id: 1,
        name: 'test_repo',
        fullName: 'test_user/test_repo',
        description: null,
        stargazersCount: 100,
        forksCount: 50,
        htmlUrl: 'https://github.com/test_user/test_repo',
        owner: tOwnerEntity,
      );

      // act
      final props = tRepositoryEntityWithNullDescription.props;

      // assert
      expect(props.contains(null), isTrue);
      expect(tRepositoryEntityWithNullDescription.description, isNull);
    });

    test('should not be equal when properties are different', () {
      // arrange
      const tRepositoryEntity1 = RepositoryEntity(
        id: 1,
        name: 'test_repo',
        fullName: 'test_user/test_repo',
        description: 'A test repository',
        stargazersCount: 100,
        forksCount: 50,
        htmlUrl: 'https://github.com/test_user/test_repo',
        owner: tOwnerEntity,
      );
      const tRepositoryEntity2 = RepositoryEntity(
        id: 2,
        name: 'different_repo',
        fullName: 'test_user/different_repo',
        description: 'A different repository',
        stargazersCount: 200,
        forksCount: 75,
        htmlUrl: 'https://github.com/test_user/different_repo',
        owner: tOwnerEntity,
      );

      // act & assert
      expect(tRepositoryEntity1, isNot(equals(tRepositoryEntity2)));
    });

    test('should handle edge cases for numeric values', () {
      // arrange
      const tRepositoryEntityWithZeros = RepositoryEntity(
        id: 0,
        name: 'empty_repo',
        fullName: 'user/empty_repo',
        description: 'Empty repository',
        stargazersCount: 0,
        forksCount: 0,
        htmlUrl: 'https://github.com/user/empty_repo',
        owner: tOwnerEntity,
      );

      // act & assert
      expect(tRepositoryEntityWithZeros.stargazersCount, equals(0));
      expect(tRepositoryEntityWithZeros.forksCount, equals(0));
      expect(tRepositoryEntityWithZeros.htmlUrl, 'https://github.com/user/empty_repo');
    });
  });
}