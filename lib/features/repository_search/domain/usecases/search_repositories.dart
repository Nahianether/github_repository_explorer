import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/search_result_entity.dart';
import '../repositories/repository_repository.dart';

class SearchRepositoriesUseCase implements UseCase<SearchResultEntity, SearchRepositoriesParams> {
  final RepositoryRepository repository;

  SearchRepositoriesUseCase(this.repository);

  @override
  Future<Either<Failure, SearchResultEntity>> call(SearchRepositoriesParams params) async {
    return await repository.searchRepositories(
      query: params.query,
      page: params.page,
      perPage: params.perPage,
    );
  }
}

class SearchRepositoriesParams {
  final String query;
  final int page;
  final int perPage;

  const SearchRepositoriesParams({
    required this.query,
    required this.page,
    required this.perPage,
  });
}