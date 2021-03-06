// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobModel _$JobModelFromJson(Map<String, dynamic> json) {
  return JobModel(
    id: json['id'] as int,
    title: json['title'] as String,
    description: json['description'] as String,
    date: json['date'] as String,
    budget: json['budget'] as String,
    awarded: json['awarded'] as bool,
    private: json['private'] as bool,
    created_at: json['created_at'] as String,
    updated_at: json['updated_at'] as String,
    client_id: json['client_id'] as int,
    trader_id: json['trader_id'] as int,
    location_id: json['location_id'] as int,
    tag_ids: (json['tag_ids'] as List)?.map((e) => e as int)?.toList(),
  );
}

Map<String, dynamic> _$JobModelToJson(JobModel instance) => <String, dynamic>{
      'title': instance.title,
      'id': instance.id,
      'description': instance.description,
      'date': instance.date,
      'budget': instance.budget,
      'awarded': instance.awarded,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'client_id': instance.client_id,
      'trader_id': instance.trader_id,
      'private': instance.private,
      'location_id': instance.location_id,
      'tag_ids': instance.tag_ids,
    };
