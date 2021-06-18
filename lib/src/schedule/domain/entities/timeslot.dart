import 'package:equatable/equatable.dart';

class Timeslot extends Equatable {
  DateTime startDateTime;
  DateTime endDateTime;
  int interval;

  Timeslot({
    this.startDateTime,
    this.endDateTime,
    this.interval,
  });

  @override
  List<Object> get props => [startDateTime, endDateTime, interval];
}