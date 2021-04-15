import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';
import '../models/job_model.dart';
import 'job_rest_api_client.dart';
import 'job_remote_data_source.dart';
import '../../../../core.dart';

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
      logger.severe("Exception occured in showUser", error, stacktrace);
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
      logger.severe("Exception occured in showUser", error, stacktrace);
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
      logger.severe("Exception occured in showUser", error, stacktrace);
      throw ServerException.withError(error: error);
    }

    return data;
  }

  @override
  Future<JobModel> createJob(JobModel job) {
    // TODO: implement createJob
    throw UnimplementedError();
  }

  @override
  Future<void> deleteJob(int id) {
    // TODO: implement deleteJob
    throw UnimplementedError();
  }

  @override
  Future<JobModel> showJob(int id) {
    // TODO: implement showJob
    throw UnimplementedError();
  }

  @override
  Future<JobModel> updateJob(JobModel job) {
    // TODO: implement updateJob
    throw UnimplementedError();
  }

}