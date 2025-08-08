import 'github_api_service.dart';
import 'repository_remote_data_source.dart';
import '../../models/search_result_model.dart';

class RepositoryRemoteDataSourceImpl implements RepositoryRemoteDataSource {
  final GitHubApiService apiService;

  RepositoryRemoteDataSourceImpl({required this.apiService});

  @override
  Future<SearchResultModel> searchRepositories(
    String query,
    String sort,
    String order,
    int page,
    int perPage,
  ) async {
    return await apiService.searchRepositories(query, sort, order, page, perPage);
  }
}