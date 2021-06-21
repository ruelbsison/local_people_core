import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../domain/entities/booking.dart';
import '../../domain/entities/booking_response.dart';
import '../../domain/entities/booking_list_response.dart';
import '../../domain/repositories/booking_repository.dart';
//import 'package:local_people_core/auth.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepository bookingRepository;
  BookingBloc({
    @required this.bookingRepository,
  }) : super(BookingInitial());

  @override
  Stream<BookingState> mapEventToState(
    BookingEvent event,
  ) async* {
    if (event is BookingAddEvent) {
      yield BookingAdding();
      yield* _mapAddBookingToState(event.booking);
    } else if (event is JobBookingLoadEvent) {
      yield JobBookingLoading();
      yield* _mapLoadJobBookingToState(event.jobId);
    }
  }

  Stream<BookingState> _mapAddBookingToState(Booking booking) async* {
    try {
      BookingResponse response = await bookingRepository.createBooking(booking);
      if (response == null) {
        yield BookingAddFailed('');
      } else if (response.exception != null) {
        yield BookingAddFailed(response.exception.toString());
      } else if (response.booking != null) {
        yield BookingAdded(response.booking);
      }
    } catch (e) {
      print(e.toString());
      yield BookingAddFailed(e.toString());
    }
  }

  Stream<BookingState> _mapLoadJobBookingToState(int jobId) async* {
    try {
      BookingListResponse response = await bookingRepository.listJobBookings(jobId);
      if (response == null) {
        yield JobBookingFailed('');
      } else if (response.exception != null) {
        yield JobBookingFailed(response.exception.toString());
      } else if (response.bookings != null) {
        yield JobBookingLoaded(response.bookings);
      }
    } catch (e) {
      print(e.toString());
      yield JobBookingFailed(e.toString());
    }
  }
}
