import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'change_request_model.g.dart';

@JsonSerializable()
class ChangeRequestModel extends Equatable {
  int id;
  String date;
  int duration;
  String status;
  int trader_id;
  int job_id;
  int client_id;
  String created_at;
  String updated_at;

  ChangeRequestModel(
      {this.id,
      @required this.date,
      @required this.duration,
      @required this.status,
      @required this.trader_id,
      @required this.job_id,
        @required this.client_id,
      this.created_at,
      this.updated_at})
      : assert(client_id != null),
        assert(status != null),
        assert(job_id != null);

  @override
  List<Object> get props =>
      [id, date, duration, date, status, trader_id, job_id, client_id, created_at, updated_at];

  factory ChangeRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ChangeRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChangeRequestModelToJson(this);

  // ChangeRequestModel.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   date = json['date'];
  //   duration = json['duration'];
  //   status = json['status'];
  //   traderId = json['trader_id'];
  //   jobId = json['job_id'];
  //   createdAt = json['created_at'];
  //   updatedAt = json['updated_at'];
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['date'] = this.date;
  //   data['duration'] = this.duration;
  //   data['status'] = this.status;
  //   data['trader_id'] = this.traderId;
  //   data['job_id'] = this.jobId;
  //   data['created_at'] = this.createdAt;
  //   data['updated_at'] = this.updatedAt;
  //   return data;
  // }
}
