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
    read: json['read'] as bool,
    client_id: json['client_id'] as int,
    trader_idt: json['trader_idt'] as int,
    created_at: json['created_at'] as String,
    updated_at: json['updated_at'] as String,
  )..job_id = json['job_id'] as int;
}

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subject': instance.subject,
      'client_id': instance.client_id,
      'trader_idt': instance.trader_idt,
      'body': instance.body,
      'read': instance.read,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'job_id': instance.job_id,
    };
