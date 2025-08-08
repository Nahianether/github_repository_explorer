import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/search_result_entity.dart';
import '../repositories/repository_repository.dart';

class RefreshRepositoriesUseCase implements UseCase<SearchResultEntity, RefreshRepositoriesParams> {
  final RepositoryRepository repository;

  RefreshRepositoriesUseCase(this.repository);

  @override
  Future<Either<Failure, SearchResultEntity>> call(RefreshRepositoriesParams params) async {
    return await repository.refreshRepositories(
      query: params.query,
      page: params.page,
      perPage: params.perPage,
    );
  }
}

class RefreshRepositoriesParams {
  final String query;
  final int page;
  final int perPage;

  const RefreshRepositoriesParams({
    required this.query,
    required this.page,
    required this.perPage,
  });
}