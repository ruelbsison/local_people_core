import '../../domain/entities/job_list_response.dart';
import '../../domain/entities/job_response.dart';
import '../models/job_model.dart';

abstract class JobRemoteDataSource {
  Future<JobListResponse> listJobs();

  Future<JobListResponse> listClientJobs(int client_id);

  Future<JobListResponse> listTraderJobs(int trader_id);

  Future<JobResponse> createJob(JobModel job, List<String> files);

  Future<JobResponse> showJob(int id);

  Future<JobResponse> updateJob(JobModel job);

  Future<Exception> deleteJob(int id);

  //Future<String> createJob2(JobModel job, [List<String> files]);
}