import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart' hide Headers;
//import 'package:http/http.dart';
import 'package:retrofit/retrofit.dart';
//import 'package:http/http.dart';
import '../models/job_model.dart';
import '../../../core/configs/rest_api_config.dart';
import 'package:http_parser/http_parser.dart';
import 'package:retrofit/http.dart';

part 'job_rest_api_client.g.dart';

@RestApi(baseUrl: "http://localhost:3001/api/v1/")
abstract class JobRestApiClient {
  factory JobRestApiClient(Dio dio, {String baseUrl}) = _JobRestApiClient;

  @GET(RestAPIConfig.job)
  //Future<Response> listUsers();
  Future<List<JobModel>> listJobs();

  @GET(RestAPIConfig.jobClient)
  //Future<Response> listUsers();
  Future<List<JobModel>> listJobsForClient(@Path("id") int id);

  @GET(RestAPIConfig.jobTrader)
  //Future<Response> listUsers();
  Future<List<JobModel>> listJobsForTrader(@Path("id") int id);

  //@ContentType('multipart/form-data')
  //@MultiPart()
  @Headers(<String, dynamic>{
    "Content-Type" : "multipart/form-data",
  })
  @POST(RestAPIConfig.job)
  //Future<JobModel> createJob(JobModel formData);
  //Future<JobModel> createJob(@Part() List<int> job, @Part() List<File> images);
  //Future<JobModel> createJob(@Header("Content-Type") String contentType, @Body() FormData formData);
  Future<JobModel> createJob(@Body() FormData formData);
  //Future<JobModel> createJob(@MultiPart() List<MultipartFile> formData);

  @GET(RestAPIConfig.jobWithId)
  //Future<Response> showUser(String id);
  Future<JobModel> showJob(@Path("id") int id);

  @PATCH(RestAPIConfig.jobWithId)
  Future<JobModel> updateJob(@Path("id") int id, @Body() JobModel job);

  @DELETE(RestAPIConfig.jobWithId)
  Future<void> deleteJob(@Path("id") int id);
}





