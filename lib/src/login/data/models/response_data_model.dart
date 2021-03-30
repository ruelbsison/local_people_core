import 'package:json_annotation/json_annotation.dart';

part 'response_data_model.g.dart';

@JsonSerializable()
class ResponseDataModel{
  int code;
  dynamic meta;
  List<dynamic>data;
  ResponseDataModel({this.code, this.meta, this.data});
  factory ResponseDataModel.fromJson(Map<String, dynamic> json) => _$ResponseDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseDataModelToJson(this);

}