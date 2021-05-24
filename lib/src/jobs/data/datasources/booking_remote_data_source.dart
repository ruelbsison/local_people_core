import '../models/booking_model.dart';
import '../../domain/entities/booking_list_response.dart';
import '../../domain/entities/booking_response.dart';

abstract class BookingRemoteDataSource {
  Future<BookingListResponse> listTraderBookings(int traderId);

  Future<BookingListResponse> listJobBookings(int jobId);

  Future<BookingResponse> createBooking(BookingModel booking);

  Future<BookingResponse> showBooking(int id);

  Future<BookingResponse> updateBooking(BookingModel booking);

  Future<Exception> deleteBooking(int id);
}