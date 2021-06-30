import 'dart:async';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/schedule.dart';
import '../../domain/entities/timeslot.dart';
//import '../../data/repositories/schedule_repository.dart';
import 'package:intl/intl.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/auth.dart';
import 'package:local_people_core/jobs.dart';
import 'package:local_people_core/quote.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  //final ScheduleRepository scheduleRepository = ScheduleRepository();
  final JobRepository jobRepository;
  final AppType appType;
  final AuthLocalDataSource authLocalDataSource;
  final QuoteRepository quoteRepository;
  final BookingRepository bookingRepository;

  final _timeslotController = StreamController<List<Timeslot>>.broadcast();

  get timeslots => _timeslotController.stream;

  // final _scheduleController = StreamController<List<Schedule>>.broadcast();
  //
  // get schedules => _scheduleController.stream;

  DateTime dayStartTime;

  DateTime dayEndTime;

  int lastInterval = -1;

  List<Timeslot> quotedTimeslotsList = [];

  ScheduleBloc({
    @required this.appType,
    @required this.jobRepository,
    @required this.quoteRepository,
    @required this.bookingRepository,
    @required this.authLocalDataSource,
  }) : super(ScheduleInitial());

  @override
  Stream<ScheduleState> mapEventToState(
    ScheduleEvent event,
  ) async* {
    if (event is TimeSlotLoadEvent) {
      yield TimeSlotLoading();
      yield* _mapTimeSlotLoadToState(event.interval);
    } else if (event is ScheduleLoadEvent) {
      yield ScheduleLoading();
      yield* _mapScheduleLoadToState();
    }
  }

  Stream<ScheduleState> _mapTimeSlotLoadToState(int interval) async* {

  }

  Stream<ScheduleState> _mapScheduleLoadToState() async* {
    List<Schedule> scheduleList = [];

    List<Booking> bookingList = [];
    int traderId = await authLocalDataSource.getUserId();
    if (traderId != null && traderId > 0) {
      try {
        BookingListResponse response = await bookingRepository
            .listTraderBookings(traderId);
        if (response == null) {
          print('Unknown error occured from listTraderBookings');
        } else if (response.exception != null) {
          print(response.exception.toString());
        } else if (response.bookings != null) {
          bookingList = response.bookings;
        }
      } catch (e) {
        print('listTraderBookings: ' + e.toString());
      }

      var listIterator = bookingList.iterator;
      while (listIterator.moveNext()) {
        Booking booking = listIterator.current;
        try {
          JobResponse jobResponse = await jobRepository.showJob(booking.jobId);
          if (jobResponse == null) {
            print('Unknown error occured from showJob');
            yield ScheduleLoadFailed('Unknown error occured from showJob');
          } else if (jobResponse != null && jobResponse.exception != null) {
            print(jobResponse.exception.toString());
            yield ScheduleLoadFailed(jobResponse.exception.toString());
          } else if (jobResponse.job != null) {
            Job job = jobResponse.job;
            Schedule schedule = Schedule(
              jobId: job.id,
              clientId: job.clientId,
              title: job.title != null ? job.title
                  : job.description != null ? job.description
                  : '',
              description: job.preview != null ? job.preview
                  : job.description != null ? job.description
                  : job.title != null ? job.title
                  : '',
              bookingId: booking.id,
              startDateTime: booking.startTime,
              endDateTime: booking.endTime,
              traderId: booking.traderId,
              type: ScheduleType.BOOKED_SCHEDULE,
            );
            scheduleList.add(schedule);
          }
        } catch (e) {
          print('_mapScheduleLoadToState: ' + e.toString());
          yield ScheduleLoadFailed(e.toString());
        }
      }
      yield ScheduleLoaded(scheduleList);
    }
  }

  //  Future<List<Schedule>> getSchedules() async {
  //   List<Schedule> scheduleList = [];
  //
  //   List<Booking> bookingList = [];
  //   int traderId = await authLocalDataSource.getUserId();
  //   if (traderId != null && traderId > 0) {
  //     try {
  //       BookingListResponse response = await bookingRepository.listTraderBookings(traderId);
  //       if (response == null) {
  //         print('Unknown error occured from listTraderBookings');
  //       } else if (response.exception != null) {
  //         print(response.exception.toString());
  //       } else if (response.bookings != null) {
  //         bookingList = response.bookings;
  //       }
  //     } catch (e) {
  //       print('listTraderBookings: ' + e.toString());
  //     }
  //
  //     var listIterator = bookingList.iterator;
  //     while (listIterator.moveNext()) {
  //       Booking booking = listIterator.current;
  //       try {
  //         JobResponse jobResponse = await jobRepository.showJob(booking.jobId);
  //         if (jobResponse == null) {
  //           print('Unknown error occured from showJob');
  //         } else if (jobResponse != null && jobResponse.exception != null) {
  //           print(jobResponse.exception.toString());
  //         } else if (jobResponse.job != null) {
  //           Job job = jobResponse.job;
  //           Schedule schedule = Schedule(
  //             jobId: job.id,
  //             clientId: job.clientId,
  //             title: job.title != null ? job.title
  //                 : job.description != null ? job.description
  //                 : '',
  //             description: job.preview != null ? job.preview
  //                 : job.description != null ? job.description
  //                 : job.title != null ? job.title
  //                 : '',
  //             bookingId: booking.id,
  //             startDateTime: booking.startTime,
  //             endDateTime: booking.endTime,
  //             traderId: booking.traderId,
  //             type: ScheduleType.BOOKED_SCHEDULE,
  //           );
  //           scheduleList.add(schedule);
  //         }
  //
  //         _scheduleController.sink.add(scheduleList);
  //       } catch (e) {
  //         print('showJob: ' + e.toString());
  //       }
  //     }
  //   }
  //   return Future.value(scheduleList);
  // }

  Future<List<Timeslot>> getQuotedTimeslots(int traderId) async {
    List<Timeslot> quotedTimeslotsList = [];

    try {
      QuoteListResponse response = await quoteRepository.listTraderQuotes(traderId);
      if (response != null && response.exception != null) {
        print(response.exception.toString());
      } else if (response != null && response.quotes == null) {
      } else if (response != null && response.quotes != null) {
        var listIterator = response.quotes.iterator;
        while (listIterator.moveNext()) {
          Quote quote = listIterator.current;
          Timeslot timeslot = Timeslot(
            startDateTime: quote.deliveryDate,
            endDateTime: quote.deliveryDate.add(
                Duration(hours: quote.dureationRequired)
            ),
            interval: quote.dureationRequired,
          );
          quotedTimeslotsList.add(timeslot);
        }
      }
    } catch (e) {
      print(e.toString());
    }

    return Future.value(quotedTimeslotsList);
  }

  Timeslot findTimeslot(Timeslot timeslot) => quotedTimeslotsList
      .firstWhere((quotetimeslot) => quotetimeslot.startDateTime.isAfter(timeslot.startDateTime)
      && quotetimeslot.endDateTime.isBefore(timeslot.endDateTime));

   getTimeslots({int interval}) async {
    DateTime tomorrow = DateTime.now().add(Duration(days: 1));
    if (interval != lastInterval) {
      dayStartTime = DateTime.parse(DateFormat("yyyy-MM-dd'T'09:00:00.ms'Z'").format(tomorrow)); //DateTime.parse(DateFormat('dd-MM-yyyy 09:00:00').format(tomorrow));
      dayEndTime = DateTime.parse(DateFormat("yyyy-MM-dd'T'18:00:00.ms'Z'").format(tomorrow)); //DateTime.parse(DateFormat('dd-MM-yyyy 18:00:00').format(tomorrow));

      quotedTimeslotsList.clear();
      int traderId = await authLocalDataSource.getUserId();
      if (traderId != null && traderId > 0) {
        quotedTimeslotsList = await getQuotedTimeslots(traderId);
      }
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

      Timeslot quoteTimeslot;
      if (quotedTimeslotsList != null && quotedTimeslotsList.length > 0) {
        try {
          quoteTimeslot = findTimeslot(timeslot);
        } catch(e) {}
      }
      if (quoteTimeslot == null)
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

    //return Future.value(list);
  }
}
