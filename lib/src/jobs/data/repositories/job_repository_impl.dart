import 'package:local_people_core/jobs.dart';
import 'package:logging/logging.dart';
import '../../domain/entities/job.dart';
import 'package:meta/meta.dart';

import '../../domain/repositories/job_repository.dart';
import '../datasources/job_remote_data_source.dart';
import '../models/job_model.dart';
import 'package:local_people_core/auth.dart';
import '../../domain/entities/job_list_response.dart';
import '../../domain/entities/job_response.dart';

class JobRepositoryImpl implements JobRepository {
  final logger = Logger("JobRepositoryImpl");
  final AuthLocalDataSource authLocalDataSource;
  final JobRemoteDataSource jobRemoteDataSource;

  JobRepositoryImpl({
    @required this.authLocalDataSource,
    @required this.jobRemoteDataSource
  }) : assert(authLocalDataSource != null), assert(jobRemoteDataSource != null);

  @override
  Future<List<Job>> getAllJobs() async {
    JobListResponse response = await jobRemoteDataSource.listJobs();
    if (response.exception != null) {
      logger.severe("Exception occured in getAllJobs", response.exception);
    }

    return response.jobs;
  }

  @override
  Future<List<Job>> getRequestedJobs() async {
    JobListResponse response;
    try {
      int userId = await authLocalDataSource.getUserId();
      response = await jobRemoteDataSource.listJobsForTrader(userId);
      if (response.exception != null) {
        logger.severe("Exception occured in getRequestedJobs", response.exception);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in getRequestedJobs", error, stacktrace);
      return null;
    }

    return response.jobs;
  }

  @override
  Future<List<Job>> getPostedJobs() async {
    JobListResponse response;
    try {
      await authLocalDataSource.hasAuth();
      String token = await authLocalDataSource.getToken();
      if (token != null) {
        logger.info('toke: ' + token);
      }
      int userId = await authLocalDataSource.getUserId();
      response = await jobRemoteDataSource.listJobsForClient(userId);
      if (response.exception != null) {
        logger.severe("Exception occured in getPostedJobs", response.exception);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in getPostedJobs", error, stacktrace);
      return null;
    }

    return response.jobs;
  }

  @override
  Future<Job> postJob(Job job) async {
    JobResponse response;
    try {
      int userId = await authLocalDataSource.getUserId();
      job.client_id = userId;
      JobModel model = JobModel.fromJob(job);
      response = await jobRemoteDataSource.createJob(model, job.images);
      if (response.exception != null) {
        logger.severe("Exception occured in postJob", response.exception);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in postJob $error $stacktrace", error, stacktrace);
      return null;
    }

    return response.job;
  }

}