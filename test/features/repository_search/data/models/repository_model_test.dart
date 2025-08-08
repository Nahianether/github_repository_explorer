import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_repository_explorer/features/repository_search/data/models/repository_model.dart';
import 'package:github_repository_explorer/features/repository_search/data/models/owner_model.dart';
import 'package:github_repository_explorer/features/repository_search/domain/entities/repository_entity.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tOwnerModel = OwnerModel(
    id: 1,
    login: 'octocat',
    avatarUrl: 'https://github.com/images/error/octocat_happy.gif',
  );

  const tRepositoryModel = RepositoryModel(
    id: 1296269,
    name: 'Hello-World',
    fullName: 'octocat/Hello-World',
    description: 'This your first repo!',
    stargazersCount: 80,
    forksCount: 9,
    htmlUrl: 'https://github.com/octocat/Hello-World',
    owner: tOwnerModel,
  );

  group('RepositoryModel', () {
    test('should be a subclass of RepositoryEntity', () {
      // arrange & act & assert
      expect(tRepositoryModel, isA<RepositoryEntity>());
    });

    group('fromJson', () {
      test('should return a valid model when JSON is valid', () {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
          fixture('repository.json'),
        );

        // act
        final result = RepositoryModel.fromJson(jsonMap);

        // assert
        expect(result, tRepositoryModel);
      });

      test('should handle null description correctly', () {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
          fixture('repository.json'),
        );
        jsonMap['description'] = null;

        // act
        final result = RepositoryModel.fromJson(jsonMap);

        // assert
        expect(result.description, isNull);
        expect(result.id, 1296269);
        expect(result.name, 'Hello-World');
      });

      test('should handle snake_case to camelCase conversion', () {
        // arrange
        final Map<String, dynamic> jsonMap = {
          'id': 1296269,
          'name': 'Hello-World',
          'full_name': 'octocat/Hello-World',
          'description': 'This your first repo!',
          'stargazers_count': 80,
          'forks_count': 9,
          'html_url': 'https://github.com/octocat/Hello-World',
          'owner': {
            'id': 1,
            'login': 'octocat',
            'avatar_url': 'https://github.com/images/error/octocat_happy.gif',
          },
        };

        // act
        final result = RepositoryModel.fromJson(jsonMap);

        // assert
        expect(result.stargazersCount, 80);
        expect(result.forksCount, 9);
        expect(result.fullName, 'octocat/Hello-World');
        expect(result.htmlUrl, 'https://github.com/octocat/Hello-World');
      });

      test('should throw exception when required fields are missing', () {
        // arrange
        final Map<String, dynamic> invalidJsonMap = {
          'name': 'Hello-World',
          // missing required fields
        };

        // act & assert
        expect(
          () => RepositoryModel.fromJson(invalidJsonMap),
          throwsA(isA<TypeError>()),
        );
      });
    });

    group('toJson', () {
      test('should return a JSON map containing the proper data', () {
        // act
        final result = tRepositoryModel.toJson();

        // assert
        final expectedMap = {
          'id': 1296269,
          'name': 'Hello-World',
          'full_name': 'octocat/Hello-World',
          'description': 'This your first repo!',
          'stargazers_count': 80,
          'forks_count': 9,
          'html_url': 'https://github.com/octocat/Hello-World',
          'owner': {
            'id': 1,
            'login': 'octocat',
            'avatar_url': 'https://github.com/images/error/octocat_happy.gif',
          },
        };
        expect(result, expectedMap);
      });

      test('should maintain JSON serialization consistency', () {
        // arrange
        final originalJson = json.decode(fixture('repository.json'));

        // act
        final model = RepositoryModel.fromJson(originalJson);
        final serializedJson = model.toJson();

        // assert
        expect(serializedJson, originalJson);
      });
    });

    group('equality', () {
      test('should be equal when all properties are the same', () {
        // arrange
        const tRepositoryModel1 = RepositoryModel(
          id: 1296269,
          name: 'Hello-World',
          fullName: 'octocat/Hello-World',
          description: 'This your first repo!',
          stargazersCount: 80,
          forksCount: 9,
          htmlUrl: 'https://github.com/octocat/Hello-World',
          owner: tOwnerModel,
        );
        const tRepositoryModel2 = RepositoryModel(
          id: 1296269,
          name: 'Hello-World',
          fullName: 'octocat/Hello-World',
          description: 'This your first repo!',
          stargazersCount: 80,
          forksCount: 9,
          htmlUrl: 'https://github.com/octocat/Hello-World',
          owner: tOwnerModel,
        );

        // act & assert
        expect(tRepositoryModel1, equals(tRepositoryModel2));
      });
    });
  });
}