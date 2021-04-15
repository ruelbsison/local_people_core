import '../entities/job.dart';

abstract class JobRepository {
  Future<List<Job>> getAllJobs();

  Future<List<Job>> getRequestedJobs(int trader_id);

  Future<List<Job>> getPostedJobs(int client_id);
}