// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trader_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TraderModel _$TraderModelFromJson(Map<String, dynamic> json) {
  return TraderModel(
    id: json['id'] as int,
    name: json['name'] as String,
    email: json['email'] as String,
    intro: json['intro'] as String,
    token: json['token'] as String,
    token_expiration_date: json['token_expiration_date'] as String,
    created_at: json['created_at'] as String,
    updated_at: json['updated_at'] as String,
  );
}

Map<String, dynamic> _$TraderModelToJson(TraderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'intro': instance.intro,
      'token': instance.token,
      'token_expiration_date': instance.token_expiration_date,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
