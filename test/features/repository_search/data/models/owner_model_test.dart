import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_repository_explorer/features/repository_search/data/models/owner_model.dart';
import 'package:github_repository_explorer/features/repository_search/domain/entities/owner_entity.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tOwnerModel = OwnerModel(
    id: 1,
    login: 'octocat',
    avatarUrl: 'https://github.com/images/error/octocat_happy.gif',
  );

  group('OwnerModel', () {
    test('should be a subclass of OwnerEntity', () {
      // arrange & act & assert
      expect(tOwnerModel, isA<OwnerEntity>());
    });

    group('fromJson', () {
      test('should return a valid model when JSON is valid', () {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
          fixture('owner.json'),
        );

        // act
        final result = OwnerModel.fromJson(jsonMap);

        // assert
        expect(result, tOwnerModel);
      });

      test('should handle missing optional fields gracefully', () {
        // arrange
        final Map<String, dynamic> jsonMap = {
          'id': 1,
          'login': 'octocat',
          'avatar_url': 'https://github.com/images/error/octocat_happy.gif',
        };

        // act
        final result = OwnerModel.fromJson(jsonMap);

        // assert
        expect(result.id, 1);
        expect(result.login, 'octocat');
        expect(result.avatarUrl, 'https://github.com/images/error/octocat_happy.gif');
      });

      test('should throw exception when required fields are missing', () {
        // arrange
        final Map<String, dynamic> invalidJsonMap = {
          'login': 'octocat',
          // missing id and avatar_url
        };

        // act & assert
        expect(
          () => OwnerModel.fromJson(invalidJsonMap),
          throwsA(isA<TypeError>()),
        );
      });
    });

    group('toJson', () {
      test('should return a JSON map containing the proper data', () {
        // act
        final result = tOwnerModel.toJson();

        // assert
        final expectedMap = {
          'id': 1,
          'login': 'octocat',
          'avatar_url': 'https://github.com/images/error/octocat_happy.gif',
        };
        expect(result, expectedMap);
      });

      test('should maintain JSON serialization consistency', () {
        // arrange
        final originalJson = {
          'id': 1,
          'login': 'octocat',
          'avatar_url': 'https://github.com/images/error/octocat_happy.gif',
        };

        // act
        final model = OwnerModel.fromJson(originalJson);
        final serializedJson = model.toJson();

        // assert
        expect(serializedJson, originalJson);
      });
    });

    group('equality', () {
      test('should be equal when all properties are the same', () {
        // arrange
        const tOwnerModel1 = OwnerModel(
          id: 1,
          login: 'octocat',
          avatarUrl: 'https://github.com/images/error/octocat_happy.gif',
        );
        const tOwnerModel2 = OwnerModel(
          id: 1,
          login: 'octocat',
          avatarUrl: 'https://github.com/images/error/octocat_happy.gif',
        );

        // act & assert
        expect(tOwnerModel1, equals(tOwnerModel2));
      });

      test('should not be equal when properties are different', () {
        // arrange
        const tOwnerModel1 = OwnerModel(
          id: 1,
          login: 'octocat',
          avatarUrl: 'https://github.com/images/error/octocat_happy.gif',
        );
        const tOwnerModel2 = OwnerModel(
          id: 2,
          login: 'different_user',
          avatarUrl: 'https://github.com/images/error/different.gif',
        );

        // act & assert
        expect(tOwnerModel1, isNot(equals(tOwnerModel2)));
      });
    });
  });
}