import 'package:equatable/equatable.dart';

enum ScheduleType {
  BID_TIMESLOT,
  JOB_SCEDULE
}

class Schedule extends Equatable {
  int id;
  int jobId;
  DateTime startDateTime;
  DateTime endDateTime;
  int interval;
  ScheduleType type;

  Schedule({
    this.id,
    this.jobId,
    this.startDateTime,
    this.endDateTime,
    this.interval,
    this.type,
  });

  @override
  List<Object> get props => [id, jobId,
    startDateTime, endDateTime, interval, type];
}