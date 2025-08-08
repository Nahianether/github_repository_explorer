import 'package:flutter_test/flutter_test.dart';
import 'package:github_repository_explorer/features/repository_search/domain/entities/owner_entity.dart';

void main() {
  group('OwnerEntity', () {
    const tOwnerEntity = OwnerEntity(
      id: 1,
      login: 'test_user',
      avatarUrl: 'https://example.com/avatar.png',
    );

    test('should be a subclass of Equatable', () {
      // arrange & act & assert
      expect(tOwnerEntity, isA<OwnerEntity>());
    });

    test('should have correct props for equality comparison', () {
      // arrange & act
      final props = tOwnerEntity.props;

      // assert
      expect(props, [1, 'test_user', 'https://example.com/avatar.png']);
    });

    test('should be equal when all properties are the same', () {
      // arrange
      const tOwnerEntity1 = OwnerEntity(
        id: 1,
        login: 'test_user',
        avatarUrl: 'https://example.com/avatar.png',
      );
      const tOwnerEntity2 = OwnerEntity(
        id: 1,
        login: 'test_user',
        avatarUrl: 'https://example.com/avatar.png',
      );

      // act & assert
      expect(tOwnerEntity1, equals(tOwnerEntity2));
    });

    test('should not be equal when properties are different', () {
      // arrange
      const tOwnerEntity1 = OwnerEntity(
        id: 1,
        login: 'test_user',
        avatarUrl: 'https://example.com/avatar.png',
      );
      const tOwnerEntity2 = OwnerEntity(
        id: 2,
        login: 'different_user',
        avatarUrl: 'https://example.com/different.png',
      );

      // act & assert
      expect(tOwnerEntity1, isNot(equals(tOwnerEntity2)));
    });

    test('should have consistent hashCode for equal objects', () {
      // arrange
      const tOwnerEntity1 = OwnerEntity(
        id: 1,
        login: 'test_user',
        avatarUrl: 'https://example.com/avatar.png',
      );
      const tOwnerEntity2 = OwnerEntity(
        id: 1,
        login: 'test_user',
        avatarUrl: 'https://example.com/avatar.png',
      );

      // act & assert
      expect(tOwnerEntity1.hashCode, equals(tOwnerEntity2.hashCode));
    });
  });
}