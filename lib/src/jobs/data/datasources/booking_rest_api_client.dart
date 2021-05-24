import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/booking_model.dart';
import '../../../core/configs/rest_api_config.dart';
import 'package:retrofit/http.dart';

part 'booking_rest_api_client.g.dart';

@RestApi(baseUrl: "http://localhost:3001/api/v1/")
abstract class BookingRestApiClient {
  factory BookingRestApiClient(Dio dio, {String baseUrl}) = _BookingRestApiClient;

  @GET(RestAPIConfig.bookingWithTraderId)
  Future<List<BookingModel>> listTraderBookings(@Path("id") int traderId);

  @GET(RestAPIConfig.bookingWithJobId)
  Future<List<BookingModel>> listJobBookings(@Path("id") int jobId);

  @POST(RestAPIConfig.booking)
  Future<BookingModel> createBooking(@Body() Map<String, Map<String, dynamic>> model);

  @GET(RestAPIConfig.bookingWithId)
  Future<BookingModel> showBooking(@Path("id") int id);

  @PATCH(RestAPIConfig.bookingWithId)
  Future<BookingModel> updateBooking(@Path("id") int id, @Body() Map<String, Map<String, dynamic>> model);

  @DELETE(RestAPIConfig.bookingWithId)
  Future<void> deleteBooking(@Path("id") int id);
}