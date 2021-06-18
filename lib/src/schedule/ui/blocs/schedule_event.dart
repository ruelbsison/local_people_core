//part of 'schedule_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
class ScheduleEvent extends Equatable {
  const ScheduleEvent();

  @override
  List<Object> get props => [];
}

class ScheduleTimeSlotEvent extends ScheduleEvent {
  const ScheduleTimeSlotEvent({@required this.interval});

  final int interval;

  @override
  List<Object> get props => [interval];
}
