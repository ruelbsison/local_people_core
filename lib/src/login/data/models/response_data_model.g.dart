// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseDataModel _$ResponseDataModelFromJson(Map<String, dynamic> json) {
  return ResponseDataModel(
    code: json['code'] as int,
    meta: json['meta'],
    data: json['data'] as List,
  );
}

Map<String, dynamic> _$ResponseDataModelToJson(ResponseDataModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'meta': instance.meta,
      'data': instance.data,
    };
