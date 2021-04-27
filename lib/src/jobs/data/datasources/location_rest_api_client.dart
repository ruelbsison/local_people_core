import 'dart:io';
import 'package:dio/dio.dart';
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
  Future<List<LocationModel>> listJobLocations(@Path("id") int id);

  @POST(RestAPIConfig.location)
  Future<LocationModel> createLocation(@Body() LocationModel location);

  @GET(RestAPIConfig.locationWithId)
  //Future<Response> showUser(String id);
  Future<LocationModel> showLocation(@Path("id") int id);

  @PATCH(RestAPIConfig.locationWithId)
  Future<LocationModel> updateLocation(@Path("id") int id, @Body() LocationModel location);

  @DELETE(RestAPIConfig.locationWithId)
  Future<void> deleteLocation(@Path("id") int id);
}





