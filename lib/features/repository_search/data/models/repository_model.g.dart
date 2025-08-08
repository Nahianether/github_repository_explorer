// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RepositoryModelAdapter extends TypeAdapter<RepositoryModel> {
  @override
  final int typeId = 2;

  @override
  RepositoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RepositoryModel(
      id: fields[0] as int,
      name: fields[1] as String,
      fullName: fields[2] as String,
      description: fields[3] as String?,
      stargazersCount: fields[4] as int,
      forksCount: fields[5] as int,
      htmlUrl: fields[6] as String,
      owner: fields[7] as OwnerModel,
    );
  }

  @override
  void write(BinaryWriter writer, RepositoryModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.fullName)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.stargazersCount)
      ..writeByte(5)
      ..write(obj.forksCount)
      ..writeByte(6)
      ..write(obj.htmlUrl)
      ..writeByte(7)
      ..write(obj.owner);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RepositoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepositoryModel _$RepositoryModelFromJson(Map<String, dynamic> json) =>
    RepositoryModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      fullName: json['full_name'] as String,
      description: json['description'] as String?,
      stargazersCount: (json['stargazers_count'] as num).toInt(),
      forksCount: (json['forks_count'] as num).toInt(),
      htmlUrl: json['html_url'] as String,
      owner: OwnerModel.fromJson(json['owner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RepositoryModelToJson(RepositoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'full_name': instance.fullName,
      'description': instance.description,
      'stargazers_count': instance.stargazersCount,
      'forks_count': instance.forksCount,
      'html_url': instance.htmlUrl,
      'owner': instance.owner.toJson(),
    };
