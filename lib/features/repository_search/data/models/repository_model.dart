import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/repository_entity.dart';
import 'owner_model.dart';

part 'repository_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 2)
class RepositoryModel extends RepositoryEntity {
  @HiveField(0)
  @override
  final int id;

  @HiveField(1)
  @override
  final String name;

  @HiveField(2)
  @JsonKey(name: 'full_name')
  @override
  final String fullName;

  @HiveField(3)
  @override
  final String? description;

  @HiveField(4)
  @JsonKey(name: 'stargazers_count')
  @override
  final int stargazersCount;

  @HiveField(5)
  @JsonKey(name: 'forks_count')
  @override
  final int forksCount;

  @HiveField(6)
  @JsonKey(name: 'html_url')
  @override
  final String htmlUrl;

  @HiveField(7)
  @override
  final OwnerModel owner;

  const RepositoryModel({
    required this.id,
    required this.name,
    required this.fullName,
    this.description,
    required this.stargazersCount,
    required this.forksCount,
    required this.htmlUrl,
    required this.owner,
  }) : super(
          id: id,
          name: name,
          fullName: fullName,
          description: description,
          stargazersCount: stargazersCount,
          forksCount: forksCount,
          htmlUrl: htmlUrl,
          owner: owner,
        );

  factory RepositoryModel.fromJson(Map<String, dynamic> json) =>
      _$RepositoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$RepositoryModelToJson(this);
}