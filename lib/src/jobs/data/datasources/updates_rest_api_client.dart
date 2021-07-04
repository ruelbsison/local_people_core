import 'package:dio/dio.dart';
import 'dart:async';
import 'package:retrofit/retrofit.dart';
import '../models/updates_model.dart';
import '../../../core/configs/rest_api_config.dart';
import 'package:retrofit/http.dart';

part 'updates_rest_api_client.g.dart';

@RestApi(baseUrl: "http://localhost:3001/api/v1/")
abstract class UpdatesRestApiClient {
  factory UpdatesRestApiClient(Dio dio, {String baseUrl}) = _UpdatesRestApiClient;

  @GET(RestAPIConfig.updatesWithJobId)
  Future<List<UpdatesModel>> listJobUpdatess(@Path("id") int jobId);

  @POST(RestAPIConfig.updates)
  Future<UpdatesModel> createUpdates(@Body() Map<String, Map<String, dynamic>> model);

  @GET(RestAPIConfig.updatesWithId)
  Future<UpdatesModel> showUpdates(@Path("id") int id);

  @PATCH(RestAPIConfig.updatesWithId)
  Future<UpdatesModel> updateUpdates(@Path("id") int id, @Body() Map<String, Map<String, dynamic>> model);

  @DELETE(RestAPIConfig.updatesWithId)
  Future<void> deleteUpdates(@Path("id") int id);
}
