//part of 'schedule_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../domain/entities/schedule.dart';

@immutable
abstract class ScheduleState {}

class ScheduleInitial extends ScheduleState {}

class ScheduleTimeSlotLoading extends ScheduleState {}

class ScheduleTimeSlotFailed extends ScheduleState {
  final String e;

  ScheduleTimeSlotFailed(this.e);

  @override
  String toString() {
    return 'ProfileNotLoaded{e: $e}';
  }
}

class ScheduleTimeSlotLoaded extends ScheduleState {
  final List<Schedule> timeslots;
  ScheduleTimeSlotLoaded(this.timeslots);

  @override
  List<Object> get props {
    return [timeslots];
  }
}
