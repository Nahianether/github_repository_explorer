import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/owner_entity.dart';

part 'owner_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class OwnerModel extends OwnerEntity {
  @HiveField(0)
  @override
  final int id;

  @HiveField(1)
  @override
  final String login;

  @HiveField(2)
  @JsonKey(name: 'avatar_url')
  @override
  final String avatarUrl;

  const OwnerModel({
    required this.id,
    required this.login,
    required this.avatarUrl,
  }) : super(
          id: id,
          login: login,
          avatarUrl: avatarUrl,
        );

  factory OwnerModel.fromJson(Map<String, dynamic> json) =>
      _$OwnerModelFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerModelToJson(this);
}