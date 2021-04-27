import 'package:intl/intl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:local_people_core/login.dart';
import 'package:local_people_core/src/jobs/data/models/job_model.dart';
import 'package:local_people_core/src/jobs/data/datasources/job_remote_data_source.dart';
import 'package:local_people_core/src/jobs/data/datasources/job_remote_data_source_impl.dart';
import 'package:mockito/mockito.dart';
import 'package:local_people_core/core.dart';

class MockjobRemoteDataSource extends Mock implements JobRemoteDataSource {}

void main() {
  JobRemoteDataSource jobRemoteDataSource;
  MockjobRemoteDataSource mockjobRemoteDataSource;

  setUp(() {
    mockjobRemoteDataSource = MockjobRemoteDataSource();
    jobRemoteDataSource = JobRemoteDataSourceImpl(RestAPIConfig().baseURL);
  });

  group('Given Job Models, Create The Job Data', () {
    test('Job Should Be Created Successfully', () async {

      List<JobModel> jobList = await jobRemoteDataSource.listJobs();
      JobModel jobModel1 = JobModel(
        id: 0,
        title: "Job Title 1",
        description: "Job description 1",
        budget: '100',
        awarded: false,
        //date: DateFormat('yyyyy-MM-ddThh:mm.sssZ').format(DateTime.now()),
        date: DateTime.now().toString(),
        client_id: 5,
      );
      print(jobModel1.toJson());

      // 1
      jobModel1 = await jobRemoteDataSource.createJob(jobModel1);
      // 2
      expect((jobModel1.id > 0), true);
      // 3
      expect(jobModel1.created_at.length, 24);
      expect(jobModel1.updated_at.length, 24);

      List<JobModel> userListWithNew = await jobRemoteDataSource.listJobs();
      expect(userListWithNew.length, jobList.length + 1);

      JobModel jobModel2 = JobModel(
        id: 0,
        title: "Job Title 2",
        description: "Job description 2",
        budget: '200',
        awarded: false,
        //date: DateFormat('yyyyy-MM-ddThh:mm.sssZ').format(DateTime.now()),
        date: DateTime.now().toString(),
        client_id: 6,
      );
      print(jobModel1.toJson());
      // 1
      jobModel2 = await jobRemoteDataSource.createJob(jobModel2);
      // 2
      expect((jobModel2.id > 0), true);
      // 3
      expect(jobModel2.created_at.length, 24);
      expect(jobModel2.updated_at.length, 24);

      userListWithNew = await jobRemoteDataSource.listJobs();
      expect(userListWithNew.length, jobList.length + 2);
    });
  });

  group('List Jobs, Update Job Budget Data', () {
    test('Job Should Be Updated Successfully', () async {

      List<JobModel> jobList = await jobRemoteDataSource.listJobs();
      var userListIter = jobList.iterator;
      while( userListIter.moveNext() ) {
        print(userListIter.current.toJson());

        JobModel cur = userListIter.current;
        String budget = cur.budget;
        cur.budget = (double.parse(cur.budget) + 100).toString();

        JobModel updatedJobModel = await jobRemoteDataSource.updateJob(cur);
        print(updatedJobModel.toJson());
        expect(updatedJobModel.id, cur.id);
        expect(double.parse(updatedJobModel.budget) , double.parse(budget) + 100);
      }

    });
  });

  group('List Job, Show Job Data', () {
    test('Job Should Be Shown Successfully', () async {

      List<JobModel> userList = await jobRemoteDataSource.listJobs();
      var userListIter = userList.iterator;
      while( userListIter.moveNext() ) {
        JobModel cur = userListIter.current;
        print(cur.toJson());

        JobModel showJobModel = await jobRemoteDataSource.showJob(cur.id);
        print(showJobModel.toJson());
        expect(showJobModel.id, cur.id);
        /*expect(showJobModel.name , cur.name);
        expect(showJobModel.email , cur.email);
        expect(showJobModel.token , cur.token);
        expect(showJobModel.token_expiration_date , cur.token_expiration_date);
        expect(showJobModel.created_at , cur.created_at);
        expect(showJobModel.updated_at , cur.updated_at);*/
      }

      //var largestGeekValue = userList.fold(userList[0].id, (previous, current) => previous > current ? previous : current);
      //print('largestGeekValue: ' + largestGeekValue);
    });
  });

  group('Delete Last And First Job Data', () {
    test('Job Should Be Deleted Successfully', () async {

      List<JobModel> userList = await jobRemoteDataSource.listJobs();
      if (!userList.isEmpty) {
        JobModel cur = userList.last;
        if (cur != null) {
          print(cur.toJson());
          await jobRemoteDataSource.deleteJob(cur.id);
        }
      }
      //ResponseDataModel responseDataModel = await jobRemoteDataSource.deleteUser(cur.id);
      //expect(responseDataModel.code, 204);

      if (userList.length > 0) {
        JobModel cur = userList.first;
        if (cur != null) {
          print(cur.toJson());
          await jobRemoteDataSource.deleteJob(cur.id);
        }
      }
      //responseDataModel = await jobRemoteDataSource.deleteUser(cur.id);
      //expect(responseDataModel.code, 204);
    });
  });

}