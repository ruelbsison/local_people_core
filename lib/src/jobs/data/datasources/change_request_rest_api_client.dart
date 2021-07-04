import 'package:dio/dio.dart';
import 'dart:async';
import 'package:retrofit/retrofit.dart';
import '../models/change_request_model.dart';
import '../../../core/configs/rest_api_config.dart';
import 'package:retrofit/http.dart';

part 'change_request_rest_api_client.g.dart';

@RestApi(baseUrl: "http://localhost:3001/api/v1/")
abstract class ChangeRequestRestApiClient {
  factory ChangeRequestRestApiClient(Dio dio, {String baseUrl}) = _ChangeRequestRestApiClient;

  @GET(RestAPIConfig.changeRequestWithTraderId)
  Future<List<ChangeRequestModel>> listTraderChangeRequests(@Path("id") int traderId);

  @GET(RestAPIConfig.changeRequestWithJobId)
  Future<List<ChangeRequestModel>> listJobChangeRequests(@Path("id") int jobId);

  @POST(RestAPIConfig.changeRequest)
  Future<ChangeRequestModel> createChangeRequest(@Body() Map<String, Map<String, dynamic>> model);

  @GET(RestAPIConfig.changeRequestWithId)
  Future<ChangeRequestModel> showChangeRequest(@Path("id") int id);

  @PATCH(RestAPIConfig.changeRequestWithId)
  Future<ChangeRequestModel> updateChangeRequest(@Path("id") int id, @Body() Map<String, Map<String, dynamic>> model);

  @DELETE(RestAPIConfig.changeRequestWithId)
  Future<void> deleteChangeRequest(@Path("id") int id);
}
