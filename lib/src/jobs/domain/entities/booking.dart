import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:local_people_core/core.dart';

class Booking extends Equatable {
  int id;
  String details;
  DateTime startTime;
  DateTime endTime;
  String status;
  int traderId;
  int jobId;
  String createdAt;
  String updatedAt;
  EntityStatus entityStatus;

  Booking(
      {this.id,
        @required this.details,
        @required  this.startTime,
        @required  this.endTime,
        @required this.status,
        @required this.traderId,
        @required this.jobId,
        this.entityStatus = EntityStatus.ENTIRY_STATUS_NONE,
        this.createdAt,
        this.updatedAt}):
        assert(startTime != null),
        assert(endTime != null),
        assert(traderId != null),
        assert(jobId != null);

  @override
  List<Object> get props =>
      [id, details, startTime, endTime, status, traderId, jobId, createdAt, updatedAt, entityStatus];

}
