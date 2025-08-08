import 'package:equatable/equatable.dart';
import 'repository_entity.dart';

class SearchResultEntity extends Equatable {
  final int totalCount;
  final bool incompleteResults;
  final List<RepositoryEntity> items;

  const SearchResultEntity({
    required this.totalCount,
    required this.incompleteResults,
    required this.items,
  });

  @override
  List<Object> get props => [totalCount, incompleteResults, items];
}