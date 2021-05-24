import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'requirement_model.g.dart';

@JsonSerializable()
class RequirementModel extends Equatable {
  int id;
  String title;
  String description;
  int packageId;
  String createdAt;
  String updatedAt;

  RequirementModel(
      {this.id,
      this.title,
      this.description,
      this.packageId,
      this.createdAt,
      this.updatedAt}) :
  assert(title != null),
        assert(description != null),
        assert(packageId != null);

  @override
  List<Object> get props =>
      [id, title, description, packageId, createdAt, updatedAt];

  factory RequirementModel.fromJson(Map<String, dynamic> json) =>
      _$RequirementModelFromJson(json);
  Map<String, dynamic> toJson() => _$RequirementModelToJson(this);
  
  // RequirementModel.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   title = json['title'];
  //   description = json['description'];
  //   packageId = json['package_id'];
  //   createdAt = json['created_at'];
  //   updatedAt = json['updated_at'];
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['title'] = this.title;
  //   data['description'] = this.description;
  //   data['package_id'] = this.packageId;
  //   data['created_at'] = this.createdAt;
  //   data['updated_at'] = this.updatedAt;
  //   return data;
  // }
}
