// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) {
  return ReviewModel(
    id: json['id'] as int,
    title: json['title'] as String,
    description: json['description'] as String,
    rating: json['rating'] as int,
    job_id: json['job_id'] as int,
    client_id: json['client_id'] as int,
    trader_idt: json['trader_idt'] as int,
    created_at: json['created_at'] as String,
    updated_at: json['updated_at'] as String,
  );
}

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'rating': instance.rating,
      'job_id': instance.job_id,
      'client_id': instance.client_id,
      'trader_idt': instance.trader_idt,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
