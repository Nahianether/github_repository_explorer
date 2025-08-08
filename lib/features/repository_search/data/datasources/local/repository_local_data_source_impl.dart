import 'package:hive/hive.dart';
import 'repository_local_data_source.dart';
import '../../models/search_result_model.dart';

class RepositoryLocalDataSourceImpl implements RepositoryLocalDataSource {
  final Box<SearchResultModel> cacheBox;

  RepositoryLocalDataSourceImpl(this.cacheBox);

  @override
  Future<SearchResultModel?> getCachedSearchResult(String query, int page) async {
    final key = '${query}_$page';
    return cacheBox.get(key);
  }

  @override
  Future<void> cacheSearchResult(String query, int page, SearchResultModel searchResult) async {
    final key = '${query}_$page';
    await cacheBox.put(key, searchResult);
  }
}