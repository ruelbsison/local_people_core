import 'dart:io';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/tag_model.dart';
import '../../../core/configs/rest_api_config.dart';

part 'tag_rest_api_client.g.dart';

@RestApi(baseUrl: "http://localhost:3001/api/v1/")
abstract class TagRestApiClient {
  factory TagRestApiClient(Dio dio, {String baseUrl}) = _TagRestApiClient;

  @GET(RestAPIConfig.tag)
  //Future<Response> listUsers();
  Future<List<TagModel>> listTags();

  @GET(RestAPIConfig.jobTags)
  //Future<Response> listUsers();
  Future<List<TagModel>> listJobTags(@Path("id") int id);

  @POST(RestAPIConfig.tag)
  Future<TagModel> createTag(@Body() Map<String, Map<String, dynamic>> tag);

  @GET(RestAPIConfig.tagWithId)
  //Future<Response> showUser(String id);
  Future<TagModel> showTag(@Path("id") int id);

  @PATCH(RestAPIConfig.tagWithId)
  Future<TagModel> updateTag(@Path("id") int id, @Body() Map<String, Map<String, dynamic>> tag);

  @DELETE(RestAPIConfig.tagWithId)
  Future<void> deleteTag(@Path("id") int id);
}





