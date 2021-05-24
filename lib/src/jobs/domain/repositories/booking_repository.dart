
import '../entities/booking.dart';
import '../entities/booking_response.dart';
import '../entities/booking_list_response.dart';

abstract class BookingRepository {
  Future<BookingListResponse> listTraderBookings(int traderId);

  Future<BookingListResponse> listJobBookings(int jobId);

  Future<BookingResponse> createBooking(Booking booking);

  Future<BookingResponse> showBooking(int id);

  Future<BookingResponse> updateBooking(Booking booking);

  Future<Exception> deleteBooking(int id);
}