import 'package:local_people_core/jobs.dart';
import 'package:logging/logging.dart';
import '../../domain/entities/job.dart';
import 'package:meta/meta.dart';

import '../../domain/repositories/job_repository.dart';
import '../datasources/job_remote_data_source.dart';
import '../models/job_model.dart';
import '../../domain/entities/job_list_response.dart';
import '../../domain/entities/job_response.dart';
import 'package:local_people_core/core.dart';

class JobRepositoryImpl implements JobRepository {
  final logger = Logger("JobRepositoryImpl");
  final JobRemoteDataSource jobRemoteDataSource;
  final NetworkInfo networkInfo;

  JobRepositoryImpl({
    @required this.networkInfo,
    @required this.jobRemoteDataSource
  }) : assert(networkInfo != null), assert(jobRemoteDataSource != null);

  @override
  Future<JobListResponse> listJobs() async {
    JobListResponse response = JobListResponse();
    if (await networkInfo.isConnected) {
      try {
        response = await jobRemoteDataSource.listJobs();
        if (response != null && response.exception != null) {
          logger.severe("Exception occured in listJobs", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in listJobs", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<JobResponse> postJob(Job job) async {
    JobResponse response = JobResponse();
    if (await networkInfo.isConnected) {
      try {
        JobModel model = JobModel.fromJob(job);
        response = await jobRemoteDataSource.createJob(model, job.images);
        if (response.exception != null) {
          logger.severe("Exception occured in postJob", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in postJob $error $stacktrace", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<Exception> deleteJob(int id) async {
    Exception response;
    if (await networkInfo.isConnected) {
      try {
        await jobRemoteDataSource.deleteJob(id);
      } catch (error, stacktrace) {
        logger.severe("Exception occured in deleteJob", error, stacktrace);
        response = Exception(error.toString());
      }
    } else {
      response = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<JobListResponse> listClientJobs(int client_id) async {
    JobListResponse response = JobListResponse();
    if (await networkInfo.isConnected) {
      try {
        response = await jobRemoteDataSource.listClientJobs(client_id);
        if (response != null && response.exception != null) {
          logger.severe("Exception occured in listClientJobs", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in listClientJobs", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<JobListResponse> listTraderJobs(int trader_id) async {
    JobListResponse response = JobListResponse();
    if (await networkInfo.isConnected) {
      try {
        response = await jobRemoteDataSource.listTraderJobs(trader_id);
        if (response != null && response.exception != null) {
          logger.severe("Exception occured in listJobs", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in listJobs", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<JobResponse> showJob(int id) async {
    JobResponse response = JobResponse();
    if (await networkInfo.isConnected) {
      try {
        response = await jobRemoteDataSource.showJob(id);
        if (response != null && response.exception != null) {
          logger.severe("Exception occured in showJob", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in showJob", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<JobResponse> updateJob(Job job) async {
    JobResponse response = JobResponse();
    if (await networkInfo.isConnected) {
      try {
        JobModel model = JobModel.fromJob(job);
        response = await jobRemoteDataSource.updateJob(model);
        if (response != null && response.exception != null) {
          logger.severe("Exception occured in showJob", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in showJob", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

}