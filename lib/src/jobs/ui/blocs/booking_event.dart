part of 'booking_bloc.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();
}

class BookingAddEvent extends BookingEvent {
  final Booking booking;

  BookingAddEvent({
    @required this.booking,
  });

  @override
  List<Object> get props => [booking];
}

class JobBookingLoadEvent extends BookingEvent {
  final int jobId;

  JobBookingLoadEvent({
    @required this.jobId,
  });

  @override
  List<Object> get props => [jobId];
}

