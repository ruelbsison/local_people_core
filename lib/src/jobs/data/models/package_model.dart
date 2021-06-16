import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'package_model.g.dart';

@JsonSerializable()
class PackageModel extends Equatable {
  int id;
  String name;
  String description;
  int trader_id;
  String created_at;
  String updated_at;

  PackageModel(
      {this.id,
      @required this.name,
      @required this.description,
      @required this.trader_id,
      this.created_at,
      this.updated_at})
      : assert(name != null),
        assert(description != null),
        assert(trader_id != null);

  @override
  List<Object> get props =>
      [id, name, description, trader_id, created_at, updated_at];

  factory PackageModel.fromJson(Map<String, dynamic> json) =>
      _$PackageModelFromJson(json);
  Map<String, dynamic> toJson() => _$PackageModelToJson(this);
  // PackageModel.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   name = json['name'];
  //   description = json['description'];
  //   traderId = json['trader_id'];
  //   createdAt = json['created_at'];
  //   updatedAt = json['updated_at'];
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   data['description'] = this.description;
  //   data['trader_id'] = this.traderId;
  //   data['created_at'] = this.createdAt;
  //   data['updated_at'] = this.updatedAt;
  //   return data;
  // }
}
