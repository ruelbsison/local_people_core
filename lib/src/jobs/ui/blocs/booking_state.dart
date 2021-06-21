part of 'booking_bloc.dart';

abstract class BookingState extends Equatable {
  const BookingState();
}

class BookingInitial extends BookingState {
  @override
  List<Object> get props => [];
}

class BookingAdding extends BookingState {
  @override
  List<Object> get props => [];
}

class BookingAdded extends BookingState {
  final Booking booking;

  const BookingAdded(this.booking);

  @override
  List<Object> get props {
    return [booking];
  }
}

class BookingAddFailed extends BookingState {
  final String error;

  const BookingAddFailed(this.error);

  @override
  List<Object> get props {
    return [error];
  }

  @override
  String toString() {
    return 'BookingAddFailed{error: $error}';
  }
}

class JobBookingLoading extends BookingState {
  @override
  List<Object> get props => [];
}

class JobBookingLoaded extends BookingState {
  final List<Booking> booking;

  const JobBookingLoaded(this.booking);

  @override
  List<Object> get props {
    return [booking];
  }
}

class JobBookingFailed extends BookingState {
  final String error;

  const JobBookingFailed(this.error);

  @override
  List<Object> get props {
    return [error];
  }

  @override
  String toString() {
    return 'JobBookingFailed{error: $error}';
  }
}