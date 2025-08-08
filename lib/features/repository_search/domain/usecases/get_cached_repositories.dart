import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/search_result_entity.dart';
import '../repositories/repository_repository.dart';

class GetCachedRepositoriesUseCase implements UseCase<SearchResultEntity, NoParams> {
  final RepositoryRepository repository;

  GetCachedRepositoriesUseCase(this.repository);

  @override
  Future<Either<Failure, SearchResultEntity>> call(NoParams params) async {
    return await repository.getCachedRepositories();
  }
}