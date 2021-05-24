import '../models/booking_model.dart';

import '../../domain/entities/booking_list_response.dart';

import '../../domain/entities/booking_response.dart';

import 'booking_remote_data_source.dart';
import 'booking_rest_api_client.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final logger = Logger("BookingRemoteDataSourceImpl");
  final BookingRestApiClient bookingRestApiClient;

  BookingRemoteDataSourceImpl({@required this.bookingRestApiClient})
      : assert(bookingRestApiClient != null);

  @override
  Future<BookingResponse> createBooking(BookingModel model) async {
    BookingResponse response = BookingResponse();
    try {
      var paramData = model.toJson();
      paramData.keys
          .where((k) => paramData[k] == null) // filter keys
          .toList() // create a copy to avoid concurrent modifications
          .forEach(paramData.remove); // remove selected keys
      Map<String, Map<String, dynamic>> param = Map<String, Map<String, dynamic>>();
      param['booking'] = paramData;
      BookingModel data = await bookingRestApiClient.createBooking(param);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in createBooking $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }

    return response;
  }

  @override
  Future<Exception> deleteBooking(int id) async {
    Exception response;
    try {
      await bookingRestApiClient.deleteBooking(id);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in deleteBooking $error $stacktrace", error,
          stacktrace);
      response = Exception(error.toString());
    }

    return response;
  }

  @override
  Future<BookingListResponse> listJobBookings(int jobId) async {
    BookingListResponse response = BookingListResponse();
    try {
      List<BookingModel> data = await bookingRestApiClient.listJobBookings(jobId);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listJobBookings $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }

    return response;
  }

  @override
  Future<BookingListResponse> listTraderBookings(int traderId) async {
    BookingListResponse response = BookingListResponse();
    try {
      List<BookingModel> data = await bookingRestApiClient.listTraderBookings(traderId);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listTraderBookings $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }
    return response;
  }

  @override
  Future<BookingResponse> showBooking(int id) async {
    BookingResponse response = BookingResponse();
    try {
      BookingModel data = await bookingRestApiClient.showBooking(id);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listTraderBookings $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }

    return response;
  }

  @override
  Future<BookingResponse> updateBooking(BookingModel model) async {
    BookingResponse response = BookingResponse();
    try {
      var paramData = model.toJson();
      paramData.keys
          .where((k) => paramData[k] == null) // filter keys
          .toList() // create a copy to avoid concurrent modifications
          .forEach(paramData.remove); // remove selected keys
      Map<String, Map<String, dynamic>> param = Map<String, Map<String, dynamic>>();
      param['booking'] = paramData;
      BookingModel data = await bookingRestApiClient.updateBooking(model.id, param);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in updateBooking $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }

    return response;
  }

}
