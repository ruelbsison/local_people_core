import 'package:logging/logging.dart';
import '../../domain/entities/job.dart';

import '../../domain/repositories/job_repository.dart';
import '../datasources/job_remote_data_source.dart';
import '../datasources/job_remote_data_source_impl.dart';
import '../models/job_model.dart';

class JobRepositoryImpl implements JobRepository {
  final logger = Logger("TraderRemoteDataSourceImpl");
  final String baseUrl;
  JobRemoteDataSource jobRemoteDataSource;

  JobRepositoryImpl(
    this.baseUrl
  )  : assert(baseUrl != null) {
    jobRemoteDataSource = JobRemoteDataSourceImpl(baseUrl);
  }

  @override
  Future<List<Job>> getAllJobs() async {
    List<Job> jobs;
    try {
      List<JobModel> data = await jobRemoteDataSource.listJobs();
      var listIter = data.iterator;
      while(listIter.moveNext() ) {
        JobModel model = listIter.current;
        jobs.add(
            Job(
              id: model.id, client_id: model.client_id,
              title: model.title, description: model.description,
              preview: model.description, location: '', budget: model.budget,
              tags: [], minutesLeft: 0, images: [],
            )
        );
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in showUser", error, stacktrace);
      //throw ServerException.withError(error: error);
    }

    return jobs;
  }

  @override
  Future<List<Job>> getRequestedJobs(int trader_id) async {
    List<Job> jobs;
    try {
      List<JobModel> data = await jobRemoteDataSource.listJobsForTrader(trader_id);
      var listIter = data.iterator;
      while(listIter.moveNext() ) {
        JobModel model = listIter.current;
        jobs.add(
            Job(
              id: model.id, client_id: model.client_id,
              title: model.title, description: model.description,
              preview: model.description, location: '', budget: model.budget,
              tags: [], minutesLeft: 0, images: [],
            )
        );
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in showUser", error, stacktrace);
      //throw ServerException.withError(error: error);
    }

    return jobs;
  }

  @override
  Future<List<Job>> getPostedJobs(int client_id) async {
    List<Job> jobs;
    try {
      List<JobModel> data = await jobRemoteDataSource.listJobsForClient(client_id);
      var listIter = data.iterator;
      while(listIter.moveNext() ) {
        JobModel model = listIter.current;
        jobs.add(
            Job(
                id: model.id, client_id: model.client_id,
                title: model.title, description: model.description,
                preview: model.description, location: '', budget: model.budget,
                tags: [], minutesLeft: 0, images: [],
            )
        );
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in showUser", error, stacktrace);
      //throw ServerException.withError(error: error);
    }

    return jobs;
  }

}