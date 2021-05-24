import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Booking extends Equatable {
  int id;
  String details;
  String date;
  String status;
  int traderId;
  int jobId;
  String createdAt;
  String updatedAt;

  Booking(
      {this.id,
        @required this.details,
        @required  this.date,
        @required this.status,
        @required this.traderId,
        @required this.jobId,
        this.createdAt,
        this.updatedAt}):
        assert(details != null),
        assert(date != null),
        assert(status != null),
        assert(traderId != null),
        assert(jobId != null);

  @override
  List<Object> get props =>
      [id, details, date, status, traderId, jobId, createdAt, updatedAt];

}
