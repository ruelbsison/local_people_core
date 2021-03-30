// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseDataModel _$ResponseDataModelFromJson(Map<String, dynamic> json) {
  return ResponseDataModel(
    code: json['code'] as int,
    description: json['description'] as String,
    data: json['data'] as List,
  );
}

Map<String, dynamic> _$ResponseDataModelToJson(ResponseDataModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'description': instance.description,
      'data': instance.data,
    };
