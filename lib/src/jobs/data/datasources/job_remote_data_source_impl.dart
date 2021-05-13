import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:retrofit/retrofit.dart';
//import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';
import '../models/job_model.dart';
import 'job_rest_api_client.dart';
import 'job_remote_data_source.dart';
import '../../../../core.dart';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'job_remote_data_source.dart';
import 'dart:io';
import 'dart:convert';
import 'package:mime/mime.dart';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import '../../domain/entities/job_list_response.dart';
import '../../domain/entities/job_response.dart';

class JobRemoteDataSourceImpl implements JobRemoteDataSource {
  final logger = Logger("TraderRemoteDataSourceImpl");
  final String baseUrl;
  JobRestApiClient jobRestApiClient;

  JobRemoteDataSourceImpl(@required this.baseUrl) : assert(baseUrl != null) {
    jobRestApiClient =
        JobRestApiClient(RestAPIConfig.getDioOptions(), baseUrl: baseUrl);
  }

  @override
  Future<JobListResponse> listJobs() async {
    JobListResponse reponse = JobListResponse();

    List<JobModel> data;
    try {
      data = await jobRestApiClient.listJobs();
      reponse.jobsFromModel(data);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listJobs $error $stacktrace", error,
          stacktrace);
      reponse.exception = ServerException.withError(error: error);
    }

    return reponse;
  }

  @override
  Future<JobListResponse> listJobsForClient(int client_id) async {
    JobListResponse reponse = JobListResponse();

    List<JobModel> data;
    try {
      data = await jobRestApiClient.listJobsForClient(client_id);
      reponse.jobsFromModel(data);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listJobsForClient $error $stacktrace",
          error, stacktrace);
      reponse.exception = ServerException.withError(error: error);
    }

    return reponse;
  }

  @override
  Future<JobListResponse> listJobsForTrader(int trader_id) async {
    JobListResponse reponse = JobListResponse();

    List<JobModel> data;
    try {
      data = await jobRestApiClient.listJobsForTrader(trader_id);
      reponse.jobsFromModel(data);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listJobsForTrader $error $stacktrace",
          error, stacktrace);
      reponse.exception = ServerException.withError(error: error);
    }

    return reponse;
  }

  // @override
  // Future<JobResponse> createJob(JobModel job, List<String> files) async {
  //   JobResponse reponse = JobResponse();
  //
  //   JobModel ressult;
  //   try {
  //     //var formData = new FormData();
  //     List<Map<String, String>> formFields = List<Map<String, String>>();
  //     List<File> formFiles = List<File>();
  //
  //     if (job != null) {
  //       job.id = null;
  //       Map<String, dynamic> map = job.toJson();
  //       map.forEach((k,v) => formFields.add(<String, String>{'job[$k]' : v}));
  //     }
  //
  //     if (files != null) {
  //       //int idx = 0;
  //       var fileListIter = files.iterator;
  //       while( fileListIter.moveNext() ) {
  //         String filePath = fileListIter.current;
  //         File file = File(filePath);
  //
  //         formFiles.add(file);
  //
  //         // //final bytes = await file.readAsBytes();
  //         // //String imgEncoded = base64.encode(bytes);
  //         //
  //         // //Map<String, String> charset = Map<String, String> ('charset','base64');
  //         // final mimeType = lookupMimeType(filePath);
  //         // List<String> typeSubTypes = mimeType.split('/');
  //         // //var multipartFile = MultipartFile.fromString(imgEncoded,
  //         // //var multipartFile = MultipartFile.fromBytes(bytes,
  //         // var multipartFile = await MultipartFile.fromFile(filePath,
  //         //     filename: filePath.split(Platform.pathSeparator).last,
  //         //     contentType: MediaType(typeSubTypes[0], typeSubTypes[1]));
  //         //
  //         // formData.files.add(MapEntry('job[images]', multipartFile));
  //         // //idx++;
  //       }
  //     }
  //
  //     //ressult = await jobRestApiClient.createJob(formData);
  //     ressult = await jobRestApiClient.createJob(job, formFiles);
  //     reponse.jobFromModel(ressult);
  //   } catch (error, stacktrace) {
  //     logger.severe("Exception occured in createJob $error $stacktrace", error,
  //         stacktrace);
  //     //reponse.exception = ServerException.withError(error: error);
  //   }
  //
  //   return reponse;
  // }

  @override
  Future<JobResponse> createJob(JobModel job, [List<String> files]) async {
    JobResponse reponse = JobResponse();

    String result;
    try {
      //String json = jsonEncode(job);
      //Uint8List jsonbBytes = Utf8Encoder().convert(json);

      var request =
          http.MultipartRequest('POST', Uri.parse(this.baseUrl + '/jobs'));
          Dio dio = RestAPIConfig.getDioOptions();
          request.headers.addAll(<String, String>{
            "Content-Type" : "multipart/form-data",
          });
      // Map<String, String> headers = Map<String, String>();
      // String auhtStr = dio.options.headers['Authorization'].toString();
      // headers['Authorization'] = auhtStr;
      // request.headers.addAll(headers);

      if (job != null) {
        Map<String, dynamic> map =  job.toJson();
        map.forEach((k,v) => (v != null ? request.fields.addAll(<String, String>{'job[$k]' : v.toString()}) : print(k)));
      }

      if (files != null && files.length > 0) {
        var fileListIter = files.iterator;
        while( fileListIter.moveNext() ) {
          String filePath = fileListIter.current;
          //File file = File(filePath);

          final mimeType = lookupMimeType(filePath);
          List<String> typeSubTypes = mimeType.split('/');

          request.files.add(
              http.MultipartFile(
                  'images',
                  File(filePath).readAsBytes().asStream(),
                  File(filePath).lengthSync(),
                  filename: filePath.split("/").last
              )
          );
        }
      }

      // request.files.add(
      //     http.MultipartFile.fromString(
      //         'job', jsonEncode(job),
      //         filename: 'job.json',
      //         contentType: MediaType('application', 'json'))
      // );

      http.Response res = await request
          .send()
          .then((result) async {
            http.Response.fromStream(result).then((response) {
              if (response.statusCode == 200) {
                print("Uploaded! ");
                print('response.body ' + response.body);
              }
              return response;
            });
          })
          .catchError((err) => print('error : ' + err.toString()))
          .whenComplete(() {});
      if (res != null && res.body != null) {
        reponse.jobFromModel(JobModel.fromJson(jsonDecode(res.body)));
      } else {

      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in createJob $error $stacktrace", error,
          stacktrace);
      reponse.exception = ServerException.withError(error: error);
    }

    return reponse;
  }

  @override
  Future<void> deleteJob(int id) async {
    try {
      await jobRestApiClient.deleteJob(id);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in deleteJob $error $stacktrace", error,
          stacktrace);
      throw ServerException.withError(error: error);
    }
  }

  @override
  Future<JobResponse> showJob(int id) async {
    JobResponse reponse = JobResponse();

    JobModel result;
    try {
      result = await jobRestApiClient.showJob(id);
      reponse.jobFromModel(result);
    } catch (error, stacktrace) {
      logger.severe(
          "Exception occured in showJob $error $stacktrace", error, stacktrace);
      reponse.exception = ServerException.withError(error: error);
    }

    return reponse;
  }

  @override
  Future<JobResponse> updateJob(JobModel job) async {
    JobResponse reponse = JobResponse();

    JobModel result;
    try {
      result = await jobRestApiClient.updateJob(job.id, job);
      reponse.jobFromModel(result);
    } catch (error, stacktrace) {
      logger.severe(
          "Exception occured in showJob $error $stacktrace", error, stacktrace);
      reponse.exception = ServerException.withError(error: error);
    }

    return reponse;
  }
}
