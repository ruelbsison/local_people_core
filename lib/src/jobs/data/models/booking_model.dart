import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'booking_model.g.dart';

@JsonSerializable()
class BookingModel extends Equatable {
  int id;
  String details;
  String start_time;
  String end_time;
  String status;
  int trader_id;
  int job_id;
  String created_at;
  String updated_at;

  BookingModel(
      {this.id,
        this.details,
        this.start_time,
        this.end_time,
        this.status,
        this.trader_id,
        this.job_id,
        this.created_at,
        this.updated_at}) :
        assert(start_time != null),
        assert(end_time != null),
        assert(trader_id != null),
        assert(job_id != null);

  @override
  List<Object> get props =>
      [id, start_time, details, end_time,
        status, trader_id, job_id, created_at,
        updated_at];

  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      _$BookingModelFromJson(json);
  Map<String, dynamic> toJson() => _$BookingModelToJson(this);
}
