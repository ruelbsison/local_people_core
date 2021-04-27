import 'package:dio/dio.dart';
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
import 'package:mime/mime.dart';

class JobRemoteDataSourceImpl implements JobRemoteDataSource {
  final logger = Logger("TraderRemoteDataSourceImpl");
  final String baseUrl;
  JobRestApiClient jobRestApiClient;

  JobRemoteDataSourceImpl(
    @required this.baseUrl
  )  : assert(baseUrl != null) {
    jobRestApiClient = JobRestApiClient(Dio(BaseOptions(contentType: "application/json")),
        baseUrl: baseUrl);
  }

  @override
  Future<List<JobModel>> listJobs() async {
    List<JobModel> data;
    try {
      data = await jobRestApiClient.listJobs();
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listJobs", error, stacktrace);
      throw ServerException.withError(error: error);
    }

    return data;
  }

  @override
  Future<List<JobModel>> listJobsForClient(int client_id) async {
    List<JobModel> data;
    try {
      data = await jobRestApiClient.listJobsForClient(client_id);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listJobsForClient", error, stacktrace);
      throw ServerException.withError(error: error);
    }

    return data;
  }

  @override
  Future<List<JobModel>> listJobsForTrader(int trader_id) async {
    List<JobModel> data;
    try {
      data = await jobRestApiClient.listJobsForTrader(trader_id);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listJobsForTrader", error, stacktrace);
      throw ServerException.withError(error: error);
    }

    return data;
  }

  @override
  Future<JobModel> createJob(JobModel job, [List<File> files]) async {
    JobModel ressult;
    try {
      var formData = new FormData();

      if (job != null)
        formData.fields.add( MapEntry('job', jsonEncode(job)) );

      if (files != null) {
        int idx = 0;
        var fileListIter = files.iterator;
        while( fileListIter.moveNext() ) {
          File file = fileListIter.current;

          final mimeType = lookupMimeType(file.path);
          List<String> typeSubTypes = mimeType.split('/');
          var multipartFile = await MultipartFile.fromFile(file.path,
              filename: basename(file.path),
              contentType: MediaType(typeSubTypes[0], typeSubTypes[1]));

          formData.files.add(MapEntry('image_' + idx.toString(), multipartFile));
          idx++;
        }
      }

      ressult = await jobRestApiClient.createJob(formData);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in createJob", error, stacktrace);
      throw ServerException.withError(error: error);
    }

    return ressult;
  }

  @override
  Future<void> deleteJob(int id) async {
    try {
      await jobRestApiClient.deleteJob(id);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in deleteJob", error, stacktrace);
      throw ServerException.withError(error: error);
    }
  }

  @override
  Future<JobModel> showJob(int id) async {
    JobModel ressult;
    try {
      ressult = await jobRestApiClient.showJob(id);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in showJob", error, stacktrace);
      throw ServerException.withError(error: error);
    }

    return ressult;
  }

  @override
  Future<JobModel> updateJob(JobModel job) {
    // TODO: implement updateJob
    throw UnimplementedError();
  }

}