import 'package:local_people_core/jobs.dart';
import 'package:local_people_core/src/jobs/domain/entities/location.dart';
import 'package:logging/logging.dart';
import '../../domain/entities/job.dart';
import 'package:meta/meta.dart';

import '../../domain/repositories/job_repository.dart';
import '../datasources/job_remote_data_source.dart';
import '../datasources/job_remote_data_source_impl.dart';
import '../models/job_model.dart';
import '../../domain/entities/job.dart';
import 'package:intl/intl.dart';
import 'package:local_people_core/core.dart';
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
      //AuthLocalModel authLocalModel = await authLocalDataSource.getAuth();
      //if (authLocalModel == null)
      //  throw Exception('Authorization Not Found!');

      //List<JobModel> data = await jobRemoteDataSource.listJobsForTrader(authLocalModel.userId);
      response = await jobRemoteDataSource.listJobsForTrader(2);
      if (response.exception != null) {
        logger.severe("Exception occured in getAllJobs", response.exception);
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
      //AuthLocalModel authLocalModel = await authLocalDataSource.getAuth();
      //if (authLocalModel == null)
      //  throw Exception('Authorization Not Found!');

      //List<JobModel> data = await jobRemoteDataSource.listJobsForClient(authLocalModel.userId);
      response = await jobRemoteDataSource.listJobsForClient(1);
      if (response.exception != null) {
        logger.severe("Exception occured in getAllJobs", response.exception);
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
      //AuthLocalModel authLocalModel = await authLocalDataSource.getAuth();
      //if (authLocalModel == null)
      //  throw Exception('Authorization Not Found!');

      JobModel jobModel = JobModel(
          id: 0,
          title: job.title,
          description: job.description,
          date:  job.date.toString(), //DateFormat('yyyyy-MM-ddThh:mm.sssZ').format(DateTime.now()), //job.date),
          budget: job.budget,
          awarded: false,
          client_id: 1, //authLocalModel.userId,
      );
      response = await jobRemoteDataSource.createJob(jobModel, job.images);
      if (response.exception != null) {
        logger.severe("Exception occured in getAllJobs", response.exception);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in postJob $error $stacktrace", error, stacktrace);
      return null;
    }

    return response.job;
  }

}