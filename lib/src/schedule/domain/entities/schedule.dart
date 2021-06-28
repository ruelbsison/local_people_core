import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

enum ScheduleType {
  BID_TIMESLOT,
  BOOKED_SCHEDULE
}

class Schedule extends Equatable {
  int id;
  int jobId;
  int bookingId;
  int clientId;
  int traderId;
  String title;
  String description;
  DateTime startDateTime;
  DateTime endDateTime;
  int interval;
  ScheduleType type;

  Schedule({
    this.id,
    @required this.title,
    @required this.description,
    @required this.startDateTime,
    @required this.endDateTime,
    @required this.jobId,
    @required this.bookingId,
    this.clientId,
    this.traderId,
    this.interval,
    this.type,
  });

  @override
  List<Object> get props => [id, title, description,
    jobId, bookingId, clientId, traderId,
    startDateTime, endDateTime, interval, type];
}