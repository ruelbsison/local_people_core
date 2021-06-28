part of 'schedule_bloc.dart';

class ScheduleEvent extends Equatable {
  const ScheduleEvent();

  @override
  List<Object> get props => [];
}

class TimeSlotLoadEvent extends ScheduleEvent {
  const TimeSlotLoadEvent({@required this.interval});

  final int interval;

  @override
  List<Object> get props => [interval];
}

class ScheduleLoadEvent extends ScheduleEvent {
  const ScheduleLoadEvent();

  @override
  List<Object> get props => [];
}
