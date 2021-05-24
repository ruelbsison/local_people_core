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
  int traderId;
  int jobId;
  String createdAt;
  String updatedAt;

  ChangeRequestModel(
      {this.id,
      @required this.date,
      @required this.duration,
      @required this.status,
      @required this.traderId,
      @required this.jobId,
      this.createdAt,
      this.updatedAt})
      : assert(date != null),
        assert(duration != null),
        assert(status != null),
        assert(traderId != null),
        assert(jobId != null);

  @override
  List<Object> get props =>
      [id, date, duration, date, status, traderId, jobId, createdAt, updatedAt];

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
