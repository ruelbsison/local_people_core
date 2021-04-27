import '../entities/job.dart';

abstract class JobRepository {
  Future<List<Job>> getAllJobs();

  Future<List<Job>> getRequestedJobs();

  Future<List<Job>> getPostedJobs();

  Future<Job> postJob(Job job);
}