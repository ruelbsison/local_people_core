import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../models/qualification_model.dart';
import '../../../core/configs/rest_api_config.dart';

part 'qualification_rest_api_client.g.dart';

@RestApi(baseUrl: "http://localhost:3001/api/v1/")
abstract class QualificationRestApiClient {
  factory QualificationRestApiClient(Dio dio, {String baseUrl}) = _QualificationRestApiClient;

  @GET(RestAPIConfig.qualification)
  Future<List<QualificationModel>> listQualifications();

  @GET(RestAPIConfig.qualificationWithTraderId)
  Future<List<QualificationModel>> listTraderQualifications(@Path("id") int id);

  @POST(RestAPIConfig.qualification)
  Future<QualificationModel> createQualification(@Body() Map<String, Map<String, dynamic>> qualification);

  @GET(RestAPIConfig.qualificationWithId)
  Future<QualificationModel> showQualification(@Path("id") int id);

  @PATCH(RestAPIConfig.qualificationWithId)
  Future<QualificationModel> updateQualification(@Path("id") int id, @Body() Map<String, Map<String, dynamic>> qualification);

  @DELETE(RestAPIConfig.qualificationWithId)
  Future<void> deleteQualification(@Path("id") int id);
}





