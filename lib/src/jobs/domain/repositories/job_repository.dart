import '../entities/job.dart';
import '../entities/job_response.dart';
import '../entities/job_list_response.dart';

abstract class JobRepository {
  Future<JobListResponse> listJobs();

  Future<JobListResponse> listClientJobs(int client_id);

  Future<JobListResponse> listTraderJobs(int trader_id);

  Future<JobResponse> postJob(Job job);

  Future<JobResponse> showJob(int id);

  Future<JobResponse> updateJob(Job message);

  Future<Exception> deleteJob(int id);
}