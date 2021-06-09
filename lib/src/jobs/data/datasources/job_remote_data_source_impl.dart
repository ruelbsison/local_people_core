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
import 'package:local_people_core/auth.dart';

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
          AuthLocalDataSource authLocalDataSource = sl<AuthLocalDataSource>();
          String token = await authLocalDataSource.getAccessToken();
          //String token = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IjZ5Sl81RW9zYWpkVzh1SFJSTVktZyJ9.eyJpc3MiOiJodHRwczovL2xvY2FsLXBlb3BsZS5ldS5hdXRoMC5jb20vIiwic3ViIjoiZ29vZ2xlLW9hdXRoMnwxMTQ5OTc5MTg3NDkxMTY3OTEzMzMiLCJhdWQiOlsiaHR0cHM6Ly9sb2NhbHBlb3BsZS1hcGkiLCJodHRwczovL2xvY2FsLXBlb3BsZS5ldS5hdXRoMC5jb20vdXNlcmluZm8iXSwiaWF0IjoxNjIyOTk0MTc4LCJleHAiOjE2MjMwODA1NzgsImF6cCI6IlBKb2tmRWxLaDQ0Y3QyQUZrSjBYeFZxdUh2dDVmdHcxIiwic2NvcGUiOiJvcGVuaWQgcHJvZmlsZSBlbWFpbCJ9.YmvKhcKlHQqHEj9b535zDnkWiXPX69BynnLqLdd-2sNTFxrPMHh6N-lHoO1FWBhGzzpqrVmpPSWJ4gimmml-Nad3sQcwjXTRRTmat1RD7opp6lCV2SvlV4264-THeIwHg847FOTWZBDZ0oHIs6GZeVxoQB_FjEhhwBTfkEXPOhC6YgLhzWaTR-AjRfa_e3O55A4ObcRpN00LrYxZG4EhRkC-BKlVEmYeFmusTfD72VI-obKSxXmMUNqwmUlQdj5IOUU8ugo6I4ERieOOuMYSj3PcGPK7-QFv7s2VQpeMbgtjoDLehpS6YetgHMIHb0zJUypun00X6wOW01wNmfogdg";
          if (token != null) {
            request.headers.addAll(<String, String>{
              "Authorization" : "Bearer " + token,
            });
          }
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
      // FormData formData = FormData();
      // formData.fields.add(request.fields);
      // jobRestApiClient.createJob(request.f, images);
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
