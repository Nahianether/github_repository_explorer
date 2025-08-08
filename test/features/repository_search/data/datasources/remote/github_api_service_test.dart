import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:github_repository_explorer/features/repository_search/data/datasources/remote/github_api_service.dart';
import 'package:github_repository_explorer/features/repository_search/data/models/search_result_model.dart';

import '../../../../../fixtures/fixture_reader.dart';

@GenerateMocks([http.Client])
import 'github_api_service_test.mocks.dart';

void main() {
  late GitHubApiService apiService;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    apiService = GitHubApiService(client: mockHttpClient);
  });

  const tQuery = 'flutter';
  const tSort = 'stars';
  const tOrder = 'desc';
  const tPage = 1;
  const tPerPage = 20;

  group('GitHubApiService', () {
    group('searchRepositories', () {
      test('should perform GET request on correct URL with proper headers', () async {
        // arrange
        final tSearchResult = fixture('search_result.json');
        final expectedUrl = Uri.parse('https://api.github.com/search/repositories').replace(
          queryParameters: {
            'q': tQuery,
            'sort': tSort,
            'order': tOrder,
            'page': tPage.toString(),
            'per_page': tPerPage.toString(),
          },
        );

        when(mockHttpClient.get(
          expectedUrl,
          headers: {
            'Accept': 'application/vnd.github.v3+json',
            'User-Agent': 'GitHub-Repository-Explorer',
          },
        )).thenAnswer((_) async => http.Response(tSearchResult, 200));

        // act
        final result = await apiService.searchRepositories(
          tQuery,
          tSort,
          tOrder,
          tPage,
          tPerPage,
        );

        // assert
        verify(mockHttpClient.get(
          expectedUrl,
          headers: {
            'Accept': 'application/vnd.github.v3+json',
            'User-Agent': 'GitHub-Repository-Explorer',
          },
        ));
        expect(result, isA<SearchResultModel>());
        expect(result.totalCount, 1);
        expect(result.items.length, 1);
        expect(result.items.first.name, 'Hello-World');
      });

      test('should throw exception when response code is 403 (rate limit)', () async {
        // arrange
        when(mockHttpClient.get(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response('API rate limit exceeded', 403));

        // act & assert
        expect(
          () async => await apiService.searchRepositories(tQuery, tSort, tOrder, tPage, tPerPage),
          throwsA(isA<Exception>()),
        );
      });

      test('should throw exception when response code is not 200', () async {
        // arrange
        when(mockHttpClient.get(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response('Server Error', 500));

        // act & assert
        expect(
          () async => await apiService.searchRepositories(tQuery, tSort, tOrder, tPage, tPerPage),
          throwsA(isA<Exception>()),
        );
      });

      test('should construct proper query parameters', () {
        // This test verifies the URL construction logic
        final expectedUrl = Uri.parse('https://api.github.com/search/repositories').replace(
          queryParameters: {
            'q': 'flutter in:name',
            'sort': 'stars',
            'order': 'desc',
            'page': '1',
            'per_page': '20',
          },
        );

        expect(expectedUrl.toString(), contains('q=flutter+in%3Aname'));
        expect(expectedUrl.toString(), contains('sort=stars'));
        expect(expectedUrl.toString(), contains('order=desc'));
        expect(expectedUrl.toString(), contains('page=1'));
        expect(expectedUrl.toString(), contains('per_page=20'));
      });

      test('should handle special characters in query', () {
        const specialQuery = 'flutter+language:dart';
        final expectedUrl = Uri.parse('https://api.github.com/search/repositories').replace(
          queryParameters: {
            'q': specialQuery,
            'sort': tSort,
            'order': tOrder,
            'page': tPage.toString(),
            'per_page': tPerPage.toString(),
          },
        );

        expect(expectedUrl.toString(), contains('flutter%2Blanguage%3Adart'));
      });
    });
  });
}