import 'package:dio/dio.dart';
import 'dart:async';
import 'package:retrofit/retrofit.dart';
import '../models/location_model.dart';
import '../../../core/configs/rest_api_config.dart';

part 'location_rest_api_client.g.dart';

@RestApi(baseUrl: "http://localhost:3001/api/v1/")
abstract class LocationRestApiClient {
  factory LocationRestApiClient(Dio dio, {String baseUrl}) = _LocationRestApiClient;

  @GET(RestAPIConfig.location)
  //Future<Response> listUsers();
  Future<List<LocationModel>> listLocations();

  @GET(RestAPIConfig.jobLocations)
  //Future<Response> listUsers();
  Future<LocationModel> listJobLocations(@Path("id") int id);

  @GET(RestAPIConfig.clientLocations)
  //Future<Response> listUsers();
  Future<List<LocationModel>> listClientLocations(@Path("id") int client_id);

  @GET(RestAPIConfig.traderLocations)
  //Future<Response> listUsers();
  Future<List<LocationModel>> listTraderLocations(@Path("id") int trader_id);

  @POST(RestAPIConfig.location)
  Future<LocationModel> createLocation(@Body() Map<String, Map<String, dynamic>>location);

  @GET(RestAPIConfig.locationWithId)
  //Future<Response> showUser(String id);
  Future<LocationModel> showLocation(@Path("id") int id);

  @PATCH(RestAPIConfig.locationWithId)
  Future<LocationModel> updateLocation(@Path("id") int id, @Body() Map<String, Map<String, dynamic>> location);

  @DELETE(RestAPIConfig.locationWithId)
  Future<void> deleteLocation(@Path("id") int id);
}





