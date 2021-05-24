import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';
import '../models/job_model.dart';
import 'job_rest_api_client.dart';
import 'job_remote_data_source.dart';
import '../../../../core.dart';
import 'dart:convert';
import 'dart:io';
import 'package:mime/mime.dart';
import '../../domain/entities/job_list_response.dart';
import '../../domain/entities/job_response.dart';

class JobRemoteDataSourceImpl implements JobRemoteDataSource {
  final logger = Logger("JobRemoteDataSourceImpl");
  JobRestApiClient jobRestApiClient;

  JobRemoteDataSourceImpl({@required this.jobRestApiClient})
      : assert(jobRestApiClient != null);

  @override
  Future<JobListResponse> listJobs() async {
    JobListResponse reponse = JobListResponse();
    try {
      List<JobModel> data = await jobRestApiClient.listJobs();
      reponse.jobsFromModel(data);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listJobs $error $stacktrace", error,
          stacktrace);
      reponse.exception = Exception(error.toString());
    }

    return reponse;
  }

  @override
  Future<JobListResponse> listClientJobs(int client_id) async {
    JobListResponse reponse = JobListResponse();
    try {
      List<JobModel> data = await jobRestApiClient.listJobsForClient(client_id);
      if (data != null)
        reponse.jobsFromModel(data);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listJobsForClient $error $stacktrace",
          error, stacktrace);
      reponse.exception = Exception(error.toString());
    }

    return reponse;
  }

  @override
  Future<JobListResponse> listTraderJobs(int trader_id) async {
    JobListResponse reponse = JobListResponse();

    try {
      List<JobModel> data = await jobRestApiClient.listJobsForTrader(trader_id);
      reponse.jobsFromModel(data);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listJobsForTrader $error $stacktrace",
          error, stacktrace);
      reponse.exception = Exception(error.toString());
    }

    return reponse;
  }

  @override
  Future<JobResponse> createJob(JobModel job, [List<String> files]) async {
    JobResponse response = JobResponse();
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse(RestAPIConfig().baseURL + '/jobs'));
          Dio dio = RestAPIConfig.getDioOptions();
          request.headers.addAll(<String, String>{
            "Content-Type" : "multipart/form-data",
          });

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
      http.Response httpResponse = await http.Response.fromStream(await request.send());
      print("Result: ${httpResponse.statusCode}");
      if (httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299) {
        print("Uploaded! ");
        if (httpResponse.body != null) {
          print('response.body ' + httpResponse.body);
          Map<String, dynamic> map = jsonDecode(httpResponse.body);
          print('map ' + map.toString());
          JobModel model = JobModel.fromJson(map);
          print('model ' + model.toJson().toString());
          response.jobFromModel(model);
        }
      }
      //return response.body;

      // JobModel jobModel = await request
      //     .send()
      //     .then((result) async {
      //       http.Response.fromStream(result).then((res) {
      //         JobModel model;
      //         if (res.statusCode >= 200 && res.statusCode <= 299) {
      //           print("Uploaded! ");
      //           if (res.body != null) {
      //             print('response.body ' + res.body);
      //             Map<String, dynamic> map = jsonDecode(res.body);
      //             print('map ' + map.toString());
      //             model = JobModel.fromJson(map);
      //             print('model ' + model.toJson().toString());
      //             //response.jobFromModel(model);
      //           }
      //         }
      //         return model;
      //       });
      //     })
      //     .catchError((err) => print('error : ' + err.toString()))
      //     .whenComplete(() {
      //
      // });
      // if (jobModel != null)
      //   response.jobFromModel(jobModel);
      // if (httpResponse.body == null) {
      //   print('httpResponse.body is null');
      // } else {
      //   print('httpResponse.body is not null');
      //   print('httpResponse.body ' + httpResponse.body);
      //   Map<String, dynamic> map = jsonDecode(httpResponse.body);
      //   print('map ' + map.toString());
      //   JobModel model = JobModel.fromJson(map);
      //   print('model ' + model.toJson().toString());
      //   response.jobFromModel(model);
      // }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in createJob $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }

    return response;
  }

  @override
  Future<Exception> deleteJob(int id) async {
    Exception response;
    try {
      await jobRestApiClient.deleteJob(id);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in deleteJob $error $stacktrace", error,
          stacktrace);
      response = Exception(error.toString());
    }

    return response;
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
      reponse.exception = Exception(error.toString());
    }

    return reponse;
  }

  @override
  Future<JobResponse> updateJob(JobModel model) async {
    JobResponse reponse = JobResponse();

    JobModel result;
    try {
      Map<String, Map<String, dynamic>> param = Map<String, Map<String, dynamic>>();
      param['job'] = model.toJson();
      result = await jobRestApiClient.updateJob(model.id, param);
      reponse.jobFromModel(result);
    } catch (error, stacktrace) {
      logger.severe(
          "Exception occured in showJob $error $stacktrace", error, stacktrace);
      reponse.exception = Exception(error.toString());
    }

    return reponse;
  }
}
