import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/search_result_model.dart';

class GitHubApiService {
  static const String baseUrl = "https://api.github.com";
  final http.Client client;

  GitHubApiService({http.Client? client}) : client = client ?? http.Client();

  Future<SearchResultModel> searchRepositories(
    String query,
    String sort,
    String order,
    int page,
    int perPage,
  ) async {
    final uri = Uri.parse('$baseUrl/search/repositories').replace(
      queryParameters: {
        'q': query,
        'sort': sort,
        'order': order,
        'page': page.toString(),
        'per_page': perPage.toString(),
      },
    );

    final response = await client.get(
      uri,
      headers: {
        'Accept': 'application/vnd.github.v3+json',
        'User-Agent': 'GitHub-Repository-Explorer',
      },
    );

    if (response.statusCode == 200) {
      return SearchResultModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 403) {
      throw Exception('API rate limit exceeded');
    } else {
      throw Exception('Failed to search repositories: ${response.statusCode}');
    }
  }
}