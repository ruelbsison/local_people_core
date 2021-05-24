import '../../domain/entities/booking.dart';
import '../models/booking_model.dart';
import '../../domain/entities/booking_list_response.dart';

import '../../domain/entities/booking_response.dart';
import '../../domain/repositories/booking_repository.dart';
import '../datasources/booking_remote_data_source.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';
import 'package:local_people_core/core.dart';

class BookingRepositoryImpl extends BookingRepository {
  final logger = Logger("BookingRepositoryImpl");
  final NetworkInfo networkInfo;
  final BookingRemoteDataSource bookingRemoteDataSource;

  BookingRepositoryImpl({
    @required this.networkInfo,
    @required this.bookingRemoteDataSource
  }) : assert(networkInfo != null), assert(bookingRemoteDataSource != null);

  @override
  Future<BookingResponse> createBooking(Booking booking) async {
    BookingResponse response = BookingResponse();
    if (await networkInfo.isConnected) {
      try {
        BookingModel model = BookingResponse.fromBooking(booking);
        response = await bookingRemoteDataSource.createBooking(model);
        if (response.exception != null) {
          logger.severe("Exception occured in createBooking", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in createBooking", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<Exception> deleteBooking(int id) async {
    Exception exception;
    if (await networkInfo.isConnected) {
      try {
        await bookingRemoteDataSource.deleteBooking(id);
      } catch (error, stacktrace) {
        logger.severe("Exception occured in deleteBooking", error, stacktrace);
        exception = Exception(error.toString());
      }
    } else {
      exception = InternetConnectionException();
    }

    return exception;
  }

  @override
  Future<BookingListResponse> listJobBookings(int job_id) async {
    BookingListResponse response = BookingListResponse();
    if (await networkInfo.isConnected) {
      try {
        response = await bookingRemoteDataSource.listJobBookings(job_id);
        if (response.exception != null) {
          logger.severe("Exception occured in listJobBookings", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in listJobBookings", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<BookingListResponse> listTraderBookings(int trader_id) async {
    BookingListResponse response = BookingListResponse();
    if (await networkInfo.isConnected) {
      try {
        response = await bookingRemoteDataSource.listTraderBookings(trader_id);
        if (response.exception != null) {
          logger.severe("Exception occured in listTraderBookings", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in listTraderBookings", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<BookingResponse> showBooking(int id) async {
    BookingResponse response = BookingResponse();
    if (await networkInfo.isConnected) {
      try {
        response = await bookingRemoteDataSource.showBooking(id);
        if (response.exception != null) {
          logger.severe("Exception occured in showBooking", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in showBooking", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<BookingResponse> updateBooking(Booking Booking) async {
    BookingResponse response = BookingResponse();
    if (await networkInfo.isConnected) {
      try {
        BookingModel model = BookingResponse.fromBooking(Booking);
        response = await bookingRemoteDataSource.updateBooking(model);
        if (response.exception != null) {
          logger.severe("Exception occured in updateBooking", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in updateBooking", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

}