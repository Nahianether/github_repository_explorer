import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_repository_explorer/features/repository_search/data/models/search_result_model.dart';
import 'package:github_repository_explorer/features/repository_search/data/models/repository_model.dart';
import 'package:github_repository_explorer/features/repository_search/data/models/owner_model.dart';
import 'package:github_repository_explorer/features/repository_search/domain/entities/search_result_entity.dart';

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

  const tSearchResultModel = SearchResultModel(
    totalCount: 1,
    incompleteResults: false,
    items: [tRepositoryModel],
  );

  group('SearchResultModel', () {
    test('should be a subclass of SearchResultEntity', () {
      // arrange & act & assert
      expect(tSearchResultModel, isA<SearchResultEntity>());
    });

    group('fromJson', () {
      test('should return a valid model when JSON is valid', () {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
          fixture('search_result.json'),
        );

        // act
        final result = SearchResultModel.fromJson(jsonMap);

        // assert
        expect(result, tSearchResultModel);
      });

      test('should handle empty items list correctly', () {
        // arrange
        final Map<String, dynamic> jsonMap = {
          'total_count': 0,
          'incomplete_results': false,
          'items': [],
        };

        // act
        final result = SearchResultModel.fromJson(jsonMap);

        // assert
        expect(result.totalCount, 0);
        expect(result.incompleteResults, false);
        expect(result.items, isEmpty);
      });

      test('should handle multiple items correctly', () {
        // arrange
        final Map<String, dynamic> jsonMap = {
          'total_count': 2,
          'incomplete_results': false,
          'items': [
            {
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
            },
            {
              'id': 1296270,
              'name': 'Another-Repo',
              'full_name': 'octocat/Another-Repo',
              'description': 'Another test repo!',
              'stargazers_count': 100,
              'forks_count': 15,
              'html_url': 'https://github.com/octocat/Another-Repo',
              'owner': {
                'id': 1,
                'login': 'octocat',
                'avatar_url': 'https://github.com/images/error/octocat_happy.gif',
              },
            },
          ],
        };

        // act
        final result = SearchResultModel.fromJson(jsonMap);

        // assert
        expect(result.totalCount, 2);
        expect(result.items.length, 2);
        expect(result.items[0].name, 'Hello-World');
        expect(result.items[1].name, 'Another-Repo');
      });

      test('should handle incomplete results flag correctly', () {
        // arrange
        final Map<String, dynamic> jsonMap = {
          'total_count': 1000,
          'incomplete_results': true,
          'items': [],
        };

        // act
        final result = SearchResultModel.fromJson(jsonMap);

        // assert
        expect(result.totalCount, 1000);
        expect(result.incompleteResults, true);
        expect(result.items, isEmpty);
      });

      test('should handle snake_case to camelCase conversion', () {
        // arrange
        final Map<String, dynamic> jsonMap = {
          'total_count': 1,
          'incomplete_results': false,
          'items': [],
        };

        // act
        final result = SearchResultModel.fromJson(jsonMap);

        // assert
        expect(result.totalCount, 1);
        expect(result.incompleteResults, false);
      });
    });

    group('toJson', () {
      test('should return a JSON map containing the proper data', () {
        // act
        final result = tSearchResultModel.toJson();

        // assert
        final expectedMap = {
          'total_count': 1,
          'incomplete_results': false,
          'items': [
            {
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
            },
          ],
        };
        expect(result, expectedMap);
      });

      test('should maintain JSON serialization consistency', () {
        // arrange
        final originalJson = json.decode(fixture('search_result.json'));

        // act
        final model = SearchResultModel.fromJson(originalJson);
        final serializedJson = model.toJson();

        // assert
        expect(serializedJson, originalJson);
      });
    });

    group('equality', () {
      test('should be equal when all properties are the same', () {
        // arrange
        const tSearchResultModel1 = SearchResultModel(
          totalCount: 1,
          incompleteResults: false,
          items: [tRepositoryModel],
        );
        const tSearchResultModel2 = SearchResultModel(
          totalCount: 1,
          incompleteResults: false,
          items: [tRepositoryModel],
        );

        // act & assert
        expect(tSearchResultModel1, equals(tSearchResultModel2));
      });

      test('should not be equal when properties are different', () {
        // arrange
        const tSearchResultModel1 = SearchResultModel(
          totalCount: 1,
          incompleteResults: false,
          items: [tRepositoryModel],
        );
        const tSearchResultModel2 = SearchResultModel(
          totalCount: 2,
          incompleteResults: true,
          items: [],
        );

        // act & assert
        expect(tSearchResultModel1, isNot(equals(tSearchResultModel2)));
      });
    });
  });
}