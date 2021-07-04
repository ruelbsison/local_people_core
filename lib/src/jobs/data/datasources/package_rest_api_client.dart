import 'package:dio/dio.dart';
import 'dart:async';
import 'package:retrofit/retrofit.dart';
import '../models/package_model.dart';
import '../../../core/configs/rest_api_config.dart';
import 'package:retrofit/http.dart';

part 'package_rest_api_client.g.dart';

@RestApi(baseUrl: "http://localhost:3001/api/v1/")
abstract class PackageRestApiClient {
  factory PackageRestApiClient(Dio dio, {String baseUrl}) = _PackageRestApiClient;

  @GET(RestAPIConfig.packageWithTraderId)
  Future<List<PackageModel>> listTraderPackages(@Path("id") int traderId);

  @POST(RestAPIConfig.package)
  Future<PackageModel> createPackage(@Body() Map<String, Map<String, dynamic>> model);

  @GET(RestAPIConfig.packageWithId)
  Future<PackageModel> showPackage(@Path("id") int id);

  @PATCH(RestAPIConfig.packageWithId)
  Future<PackageModel> updatePackage(@Path("id") int id, @Body() Map<String, Map<String, dynamic>> model);

  @DELETE(RestAPIConfig.packageWithId)
  Future<void> deletePackage(@Path("id") int id);
}
