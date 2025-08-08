import 'package:equatable/equatable.dart';
import 'owner_entity.dart';

class RepositoryEntity extends Equatable {
  final int id;
  final String name;
  final String fullName;
  final String? description;
  final int stargazersCount;
  final int forksCount;
  final String htmlUrl;
  final OwnerEntity owner;

  const RepositoryEntity({
    required this.id,
    required this.name,
    required this.fullName,
    this.description,
    required this.stargazersCount,
    required this.forksCount,
    required this.htmlUrl,
    required this.owner,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        fullName,
        description,
        stargazersCount,
        forksCount,
        htmlUrl,
        owner,
      ];
}