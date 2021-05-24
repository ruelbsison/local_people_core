import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'booking_model.g.dart';

@JsonSerializable()
class BookingModel extends Equatable {
  int id;
  String details;
  String date;
  String status;
  int traderId;
  int jobId;
  String createdAt;
  String updatedAt;

  BookingModel(
      {this.id,
        this.details,
        this.date,
        this.status,
        this.traderId,
        this.jobId,
        this.createdAt,
        this.updatedAt}) :
  assert(details != null),
        assert(date != null),
        assert(status != null),
        assert(traderId != null),
        assert(jobId != null);

  @override
  List<Object> get props =>
      [id, date, details, date, status, traderId, jobId, createdAt, updatedAt];

  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      _$BookingModelFromJson(json);
  Map<String, dynamic> toJson() => _$BookingModelToJson(this);
}
