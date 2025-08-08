// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SearchResultModelAdapter extends TypeAdapter<SearchResultModel> {
  @override
  final int typeId = 3;

  @override
  SearchResultModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SearchResultModel(
      totalCount: fields[0] as int,
      incompleteResults: fields[1] as bool,
      items: (fields[2] as List).cast<RepositoryModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, SearchResultModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.totalCount)
      ..writeByte(1)
      ..write(obj.incompleteResults)
      ..writeByte(2)
      ..write(obj.items);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchResultModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResultModel _$SearchResultModelFromJson(Map<String, dynamic> json) =>
    SearchResultModel(
      totalCount: (json['total_count'] as num).toInt(),
      incompleteResults: json['incomplete_results'] as bool,
      items: (json['items'] as List<dynamic>)
          .map((e) => RepositoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchResultModelToJson(SearchResultModel instance) =>
    <String, dynamic>{
      'total_count': instance.totalCount,
      'incomplete_results': instance.incompleteResults,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };
