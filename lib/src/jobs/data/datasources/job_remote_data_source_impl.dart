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
    JobResponse reponse = JobResponse();
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
      reponse.exception = Exception(error.toString());
    }

    return reponse;
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
  Future<JobResponse> updateJob(JobModel job) async {
    JobResponse reponse = JobResponse();

    JobModel result;
    try {
      result = await jobRestApiClient.updateJob(job.id, job);
      reponse.jobFromModel(result);
    } catch (error, stacktrace) {
      logger.severe(
          "Exception occured in showJob $error $stacktrace", error, stacktrace);
      reponse.exception = Exception(error.toString());
    }

    return reponse;
  }
}
