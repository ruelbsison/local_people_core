import 'package:json_annotation/json_annotation.dart';

part 'response_data_model.g.dart';

@JsonSerializable()
class ResponseDataModel{
  int code;
  String description;
  List<dynamic>data;
  ResponseDataModel({this.code, this.description, this.data});
  factory ResponseDataModel.fromJson(Map<String, dynamic> json) => _$ResponseDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseDataModelToJson(this);

}