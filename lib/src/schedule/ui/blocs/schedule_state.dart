part of 'schedule_bloc.dart';

@immutable
abstract class ScheduleState {}

class ScheduleInitial extends ScheduleState {}

class TimeSlotLoading extends ScheduleState {}

class TimeSlotLoadFailed extends ScheduleState {
  final String e;

  TimeSlotLoadFailed(this.e);

  @override
  String toString() {
    return 'TimeSlotLoadFailed{e: $e}';
  }
}

class TimeSlotLoaded extends ScheduleState {
  final List<Timeslot> timeslots;

  TimeSlotLoaded(this.timeslots);

  @override
  List<Object> get props {
    return [timeslots];
  }

  @override
  String toString() {
    return 'TimeSlotLoaded{timeslots: $timeslots}';
  }
}

class ScheduleLoading extends ScheduleState {}

class ScheduleLoadFailed extends ScheduleState {
  final String e;

  ScheduleLoadFailed(this.e);

  @override
  List<Object> get props {
    return [e];
  }

  @override
  String toString() {
    return 'ScheduleLoadFailed{e: $e}';
  }
}

class ScheduleLoaded extends ScheduleState {
  final List<Schedule> schedules;
  ScheduleLoaded(this.schedules);

  @override
  List<Object> get props {
    return [schedules];
  }

  @override
  String toString() {
    return 'ScheduleLoaded{schedules: $schedules}';
  }
}
