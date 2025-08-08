import '../../models/search_result_model.dart';

abstract class RepositoryRemoteDataSource {
  Future<SearchResultModel> searchRepositories(
    String query,
    String sort,
    String order,
    int page,
    int perPage,
  );
}