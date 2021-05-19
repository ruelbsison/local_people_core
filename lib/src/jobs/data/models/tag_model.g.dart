// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagModel _$TagModelFromJson(Map<String, dynamic> json) {
  return TagModel(
    id: json['id'] as int,
    name: json['name'] as String,
    created_at: json['created_at'] as String,
    updated_at: json['updated_at'] as String,
  );
}

Map<String, dynamic> _$TagModelToJson(TagModel instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
