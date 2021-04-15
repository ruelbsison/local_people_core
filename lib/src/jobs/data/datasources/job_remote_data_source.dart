import '../models/job_model.dart';

abstract class JobRemoteDataSource {
  Future<List<JobModel>> listJobs();

  Future<List<JobModel>> listJobsForClient(int client_id);

  Future<List<JobModel>> listJobsForTrader(int trader_id);

  Future<JobModel> createJob(JobModel job);

  Future<JobModel> showJob(int id);

  Future<JobModel> updateJob(JobModel job);

  Future<void> deleteJob(int id);
}