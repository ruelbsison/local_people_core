import 'dart:async';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/schedule.dart';
import '../../domain/entities/timeslot.dart';
import '../../data/repositories/schedule_repository.dart';
import 'package:intl/intl.dart';

//import 'package:bloc/bloc.dart';
//import 'package:meta/meta.dart';

//part 'schedule_event.dart';
//part 'schedule_state.dart';

class ScheduleBloc { //}extends Bloc<ScheduleEvent, ScheduleState> {
  final ScheduleRepository scheduleRepository = ScheduleRepository();

  final _timeslotController = StreamController<List<Timeslot>>.broadcast();

  get timeslots => _timeslotController.stream;

  DateTime dayStartTime;

  DateTime dayEndTime;

  int lastInterval = -1;

  ScheduleBloc(
    //@required this.scheduleRepository,
  ); // : super(ScheduleInitial());

  getTimeslots({int interval}) async {

    DateTime tomorrow = DateTime.now().add(Duration(days: 1));
    if (interval != lastInterval) {
      dayStartTime = DateTime.parse(DateFormat("yyyy-MM-dd'T'09:00:00.ms'Z'").format(tomorrow)); //DateTime.parse(DateFormat('dd-MM-yyyy 09:00:00').format(tomorrow));
      dayEndTime = DateTime.parse(DateFormat("yyyy-MM-dd'T'18:00:00.ms'Z'").format(tomorrow)); //DateTime.parse(DateFormat('dd-MM-yyyy 18:00:00').format(tomorrow));
    }
    DateTime startTime = dayStartTime;

    List<Timeslot> list = [];
    for (int i = 0; i < 3; i++) {
      DateTime endTime = startTime.add(Duration(hours: interval));
      Timeslot timeslot = Timeslot(
        startDateTime: startTime,
        endDateTime: endTime,
        interval: interval,
      );
      list.add(timeslot);

      startTime = endTime;
      if (startTime.isAfter(dayEndTime)) {
        tomorrow = startTime.add(Duration(days: interval));
        dayStartTime = DateTime.parse(DateFormat("yyyy-MM-dd'T'09:00:00.ms'Z'").format(tomorrow));
        dayEndTime = DateTime.parse(DateFormat("yyyy-MM-dd'T'18:00:00.ms'Z'").format(tomorrow));

        startTime = dayStartTime;
      }
    }

    lastInterval = interval;

    _timeslotController.sink.add(list);

  }

  // @override
  // Stream<ScheduleState> mapEventToState(
  //   ScheduleEvent event,
  // ) async* {
  //   // TODO: implement mapEventToState
  // }
}
