import 'package:intl/intl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:local_people_core/login.dart';
import 'package:local_people_core/src/jobs/data/models/job_model.dart';
import 'package:local_people_core/src/jobs/data/datasources/job_rest_api_client.dart';
import 'package:mockito/mockito.dart';

class MockUserRestApiClient extends Mock implements UserRestApiClient {}

void main() {
  JobRestApiClient userRestApiClient;
  MockUserRestApiClient mockUserRestApiClient;

  setUp(() {
    mockUserRestApiClient = MockUserRestApiClient();
    userRestApiClient = JobRestApiClient(Dio(BaseOptions(contentType: "application/json")));
  });

  group('Given Job Models, Create The Job Data', () {
    test('Job Should Be Created Successfully', () async {

      List<JobModel> jobList = await userRestApiClient.listJobs();
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
      jobModel1 = await userRestApiClient.createJob(jobModel1);
      // 2
      expect((jobModel1.id > 0), true);
      // 3
      expect(jobModel1.created_at.length, 24);
      expect(jobModel1.updated_at.length, 24);

      List<JobModel> userListWithNew = await userRestApiClient.listJobs();
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
      jobModel2 = await userRestApiClient.createJob(jobModel2);
      // 2
      expect((jobModel2.id > 0), true);
      // 3
      expect(jobModel2.created_at.length, 24);
      expect(jobModel2.updated_at.length, 24);

      userListWithNew = await userRestApiClient.listJobs();
      expect(userListWithNew.length, jobList.length + 2);
    });
  });

  group('List Jobs, Update Job Budget Data', () {
    test('Job Should Be Updated Successfully', () async {

      List<JobModel> jobList = await userRestApiClient.listJobs();
      var userListIter = jobList.iterator;
      while( userListIter.moveNext() ) {
        print(userListIter.current.toJson());

        JobModel cur = userListIter.current;
        String budget = cur.budget;
        cur.budget = (double.parse(cur.budget) + 100).toString();

        JobModel updatedJobModel = await userRestApiClient.updateJob(cur.id, cur);
        print(updatedJobModel.toJson());
        expect(updatedJobModel.id, cur.id);
        expect(double.parse(updatedJobModel.budget) , double.parse(budget) + 100);
      }

    });
  });

  group('List Job, Show Job Data', () {
    test('Job Should Be Shown Successfully', () async {

      List<JobModel> userList = await userRestApiClient.listJobs();
      var userListIter = userList.iterator;
      while( userListIter.moveNext() ) {
        JobModel cur = userListIter.current;
        print(cur.toJson());

        JobModel showJobModel = await userRestApiClient.showJob(cur.id);
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

      List<JobModel> userList = await userRestApiClient.listJobs();
      if (!userList.isEmpty) {
        JobModel cur = userList.last;
        if (cur != null) {
          print(cur.toJson());
          await userRestApiClient.deleteJob(cur.id);
        }
      }
      //ResponseDataModel responseDataModel = await userRestApiClient.deleteUser(cur.id);
      //expect(responseDataModel.code, 204);

      if (userList.length > 0) {
        JobModel cur = userList.first;
        if (cur != null) {
          print(cur.toJson());
          await userRestApiClient.deleteJob(cur.id);
        }
      }
      //responseDataModel = await userRestApiClient.deleteUser(cur.id);
      //expect(responseDataModel.code, 204);
    });
  });

}