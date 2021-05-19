// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationModel _$LocationModelFromJson(Map<String, dynamic> json) {
  return LocationModel(
    id: json['id'] as int,
    name: json['name'] as String,
    address: json['address'] as String,
    created_at: json['created_at'] as String,
    updated_at: json['updated_at'] as String,
    client_id: json['client_id'] as int,
    trader_id: json['trader_id'] as int,
    latitude: json['latitude'] as int,
    longitude: json['longitude'] as int,
    job_id: json['job_id'] as int,
  );
}

Map<String, dynamic> _$LocationModelToJson(LocationModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'address': instance.address,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'client_id': instance.client_id,
      'trader_id': instance.trader_id,
      'job_id': instance.job_id,
    };
