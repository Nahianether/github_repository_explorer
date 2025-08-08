import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/search_result_entity.dart';
import 'repository_model.dart';

part 'search_result_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 3)
class SearchResultModel extends SearchResultEntity {
  @HiveField(0)
  @JsonKey(name: 'total_count')
  @override
  final int totalCount;

  @HiveField(1)
  @JsonKey(name: 'incomplete_results')
  @override
  final bool incompleteResults;

  @HiveField(2)
  @override
  final List<RepositoryModel> items;

  const SearchResultModel({
    required this.totalCount,
    required this.incompleteResults,
    required this.items,
  }) : super(
          totalCount: totalCount,
          incompleteResults: incompleteResults,
          items: items,
        );

  factory SearchResultModel.fromJson(Map<String, dynamic> json) =>
      _$SearchResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResultModelToJson(this);

  SearchResultModel copyWith({
    int? totalCount,
    bool? incompleteResults,
    List<RepositoryModel>? items,
  }) {
    return SearchResultModel(
      totalCount: totalCount ?? this.totalCount,
      incompleteResults: incompleteResults ?? this.incompleteResults,
      items: items ?? this.items,
    );
  }
}