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
import 'package:local_people_core/auth.dart';

class JobRepositoryImpl implements JobRepository {
  final logger = Logger("TraderRemoteDataSourceImpl");
  final AuthLocalDataSource authLocalDataSource;
  final JobRemoteDataSource jobRemoteDataSource;

  JobRepositoryImpl({
    @required this.authLocalDataSource,
    @required this.jobRemoteDataSource
  }) : assert(authLocalDataSource != null), assert(jobRemoteDataSource != null);

  @override
  Future<List<Job>> getAllJobs() async {
    List<Job> jobs;
    try {
      List<JobModel> data = await jobRemoteDataSource.listJobs();
      var listIterData = data.iterator;
      while(listIterData.moveNext() ) {
        JobModel model = listIterData.current;
        Job job = Job(
          id: model.id,
          client_id: model.client_id,
          title: model.title,
          description: model.description,
          preview:
          model.description,
          location: Location(
            id: model.location.id,
            name: model.location.name,
          ),
          budget: model.budget,
          tags: [],
          minutesLeft: 0,
          images: [],
        );

        var listIter = model.tags.iterator;
        while (listIter.moveNext()) {
          TagModel model = listIter.current;
          job.tags.add(Tag(
            id: model.id,
            name: model.name,
          ));
        }
        jobs.add(job);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in getAllJobs", error, stacktrace);
      //throw ServerException.withError(error: error);
    }

    return jobs;
  }

  @override
  Future<List<Job>> getRequestedJobs() async {
    List<Job> jobs;
    try {
      AuthLocalModel authLocalModel = await authLocalDataSource.getAuth();
      if (authLocalModel == null)
        throw Exception('Authorization Not Found!');

      List<JobModel> data = await jobRemoteDataSource.listJobsForTrader(authLocalModel.userId);
      var listIterData = data.iterator;
      while(listIterData.moveNext() ) {
        JobModel model = listIterData.current;
        Job job = Job(
          id: model.id,
          client_id: model.client_id,
          title: model.title,
          description: model.description,
          preview:
          model.description,
          location: Location(
            id: model.location.id,
            name: model.location.name,
          ),
          budget: model.budget,
          tags: [],
          minutesLeft: 0,
          images: [],
        );
        var listIter = model.tags.iterator;
        while (listIter.moveNext()) {
          TagModel model = listIter.current;
          job.tags.add(Tag(
            id: model.id,
            name: model.name,
          ));
        }
        jobs.add(job);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in getRequestedJobs", error, stacktrace);
      //throw ServerException.withError(error: error);
    }

    return jobs;
  }

  @override
  Future<List<Job>> getPostedJobs() async {
    List<Job> jobs;
    try {
      AuthLocalModel authLocalModel = await authLocalDataSource.getAuth();
      if (authLocalModel == null)
        throw Exception('Authorization Not Found!');

      List<JobModel> data = await jobRemoteDataSource.listJobsForClient(authLocalModel.userId);
      var listIterData = data.iterator;
      while(listIterData.moveNext() ) {
        JobModel model = listIterData.current;
        Job job = Job(
          id: model.id,
          client_id: model.client_id,
          title: model.title,
          description: model.description,
          preview:
          model.description,
          location: Location(
            id: model.location.id,
            name: model.location.name,
          ),
          budget: model.budget,
          tags: [],
          minutesLeft: 0,
          images: [],
        );

        var listIter = model.tags.iterator;
        while(listIter.moveNext() ) {
          TagModel model = listIter.current;
          job.tags.add(Tag(
            id: model.id,
            name: model.name,
          ));
        }
        jobs.add(job);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in getPostedJobs", error, stacktrace);
      //throw ServerException.withError(error: error);
    }

    return jobs;
  }

  @override
  Future<Job> postJob(Job job) async {
    Job job;
    try {
      AuthLocalModel authLocalModel = await authLocalDataSource.getAuth();
      if (authLocalModel == null)
        throw Exception('Authorization Not Found!');

      JobModel jobModel = JobModel(
          id: 0,
          title: job.title,
          description: job.description,
          date: DateFormat('yyyyy-MM-ddThh:mm.sssZ').format(job.date),
          budget: job.budget,
          awarded: false,
          client_id: authLocalModel.userId,
      );
      JobModel result = await jobRemoteDataSource.createJob(jobModel, job.images);
      job = Job(
        id: result.id,
        client_id: result.client_id,
        title: result.title,
        description: result.description,
        preview: result.description,
        location: Location(
          id: result.location.id,
          name: result.location.name,
        ),
        budget: result.budget,
        //tags: result.tags,
        minutesLeft: 120,
        images: job.images,
        date: DateTime.parse(result.date),
      );

      var listIter = result.tags.iterator;
      while(listIter.moveNext() ) {
        TagModel model = listIter.current;
        job.tags.add(Tag(
          id: model.id,
          name: model.name,
        ));
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in postJob", error, stacktrace);
      //throw ServerException.withError(error: error);
    }

    return job;
  }

}