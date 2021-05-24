import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/requirement_model.dart';
import '../../../core/configs/rest_api_config.dart';
import 'package:retrofit/http.dart';

part 'requirement_rest_api_client.g.dart';

@RestApi(baseUrl: "http://localhost:3001/api/v1/")
abstract class RequirementRestApiClient {
  factory RequirementRestApiClient(Dio dio, {String baseUrl}) = _RequirementRestApiClient;

  @GET(RestAPIConfig.requirementWithPackageId)
  Future<List<RequirementModel>> listPackageRequirements(@Path("id") int packageId);

  @GET(RestAPIConfig.requirementWithJobId)
  Future<List<RequirementModel>> listJobRequirements(@Path("id") int jobId);

  @POST(RestAPIConfig.requirement)
  Future<RequirementModel> createRequirement(@Body() Map<String, Map<String, dynamic>> model);

  @GET(RestAPIConfig.requirementWithId)
  Future<RequirementModel> showRequirement(@Path("id") int id);

  @PATCH(RestAPIConfig.requirementWithId)
  Future<RequirementModel> updateRequirement(@Path("id") int id, @Body() Map<String, Map<String, dynamic>> model);

  @DELETE(RestAPIConfig.requirementWithId)
  Future<void> deleteRequirement(@Path("id") int id);
}