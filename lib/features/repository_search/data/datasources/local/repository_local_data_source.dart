import '../../models/search_result_model.dart';

abstract class RepositoryLocalDataSource {
  Future<SearchResultModel?> getCachedSearchResult(String query, int page);
  Future<void> cacheSearchResult(String query, int page, SearchResultModel searchResult);
  Future<List<SearchResultModel>> getAllCachedData();
}