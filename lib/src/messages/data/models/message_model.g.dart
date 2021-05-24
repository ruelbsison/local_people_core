// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) {
  return MessageModel(
    id: json['id'] as int,
    subject: json['subject'] as String,
    body: json['body'] as String,
    client_id: json['client_id'] as int,
    trader_id: json['trader_id'] as int,
    job_id: json['job_id'] as int,
    read: json['read'] as bool,
    created_at: json['created_at'] as String,
    updated_at: json['updated_at'] as String,
  );
}

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subject': instance.subject,
      'client_id': instance.client_id,
      'trader_id': instance.trader_id,
      'body': instance.body,
      'read': instance.read,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'job_id': instance.job_id,
    };
