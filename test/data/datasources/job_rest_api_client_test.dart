import 'package:intl/intl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/jobs.dart';
import 'package:mockito/mockito.dart';

class MockjobRemoteDataSource extends Mock implements JobRemoteDataSource {}

void main() {
  JobRemoteDataSource jobRemoteDataSource;
  MockjobRemoteDataSource mockjobRemoteDataSource;

  setUp(() {
    mockjobRemoteDataSource = MockjobRemoteDataSource();
    JobRestApiClient jobRestApiClient = JobRestApiClient(
      RestAPIConfig.getDioOptions(),
      baseUrl: RestAPIConfig().baseURL,
    );
    jobRemoteDataSource = JobRemoteDataSourceImpl(jobRestApiClient: jobRestApiClient);
  });

  // group('Given Job Models, Create The Job Data', () {
  //   test('Job Should Be Created Successfully', () async {
  //
  //     //List<JobModel> jobList = await jobRemoteDataSource.listJobs();
  //     JobModel jobModel1 = JobModel(
  //       id: 0,
  //       title: "Landayan",
  //       description: "Job description",
  //       budget: '100',
  //       awarded: false,
  //       //date: DateFormat('yyyyy-MM-ddThh:mm.sssZ').format(DateTime.now()),
  //       date: '2021-05-07T08:30:36.222Z', //DateTime.now().toString(),
  //       //location: LocationModel.empty(),
  //       client_id: 1,
  //       //tags: [TagModel.empty()],
  //     );
  //     List<String> images = List<String>();
  //     //images.add('/Users/ruelsison/Library/Developer/CoreSimulator/Devices/72B25B60-50C1-4DBF-8D3B-4047745A5B09/data/Containers/Data/Application/157882FD-D41D-40DA-A414-98F227C42D69/tmp/image_picker_90D8C03A-41C4-42B6-9496-D3606D8690E0-12167-000006A1BD199B9F.jpg');
  //     print(jobModel1.toJson());
  //
  //     Map<String, dynamic> map =  jobModel1.toJson();
  //     map.forEach((k,v) => (v != null ? print('job[$k] = $v'): print(k)));
  //     // 1
  //     JobResponse response = await jobRemoteDataSource.createJob(jobModel1, images);
  //     // 2
  //     expect((response.job != null), true);
  //     /*expect((jobModel1.id > 0), true);
  //     // 3
  //     expect(jobModel1.created_at.length, 24);
  //     expect(jobModel1.updated_at.length, 24);
  //
  //     List<JobModel> userListWithNew = await jobRemoteDataSource.listJobs();
  //     expect(userListWithNew.length, jobList.length + 1);
  //
  //     JobModel jobModel2 = JobModel(
  //       id: 0,
  //       title: "Job Title 2",
  //       description: "Job description 2",
  //       budget: '200',
  //       awarded: false,
  //       //date: DateFormat('yyyyy-MM-ddThh:mm.sssZ').format(DateTime.now()),
  //       date: DateTime.now().toString(),
  //       client_id: 6,
  //     );
  //     print(jobModel1.toJson());
  //     // 1
  //     jobModel2 = await jobRemoteDataSource.createJob(jobModel2);
  //     // 2
  //     expect((jobModel2.id > 0), true);
  //     // 3
  //     expect(jobModel2.created_at.length, 24);
  //     expect(jobModel2.updated_at.length, 24);
  //
  //     userListWithNew = await jobRemoteDataSource.listJobs();
  //     expect(userListWithNew.length, jobList.length + 2);*/
  //   });
  // });

  /*group('List Jobs, Update Job Budget Data', () {
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
  });*/

  group('List Job, Show Job Data', () {
    test('Job Should Be Shown Successfully', () async {

      JobListResponse response = await jobRemoteDataSource.listJobs();
      expect((response != null), true);
      if (response.exception != null) {
        print('response.exception: ' + response.exception.toString());
      }
      expect((response.exception == null), true);
      expect((response.jobs != null), true);

      var userListIter = response.jobs.iterator;
      while( userListIter.moveNext() ) {
        Job cur = userListIter.current;
        print(cur.toString());

        JobResponse showResponse = await jobRemoteDataSource.showJob(cur.id);
        expect((showResponse != null), true);
        if (showResponse.exception != null) {
          print('showResponse.exception: ' + showResponse.exception.toString());
        }
        expect((showResponse.exception == null), true);
        expect((showResponse.job != null), true);
        JobModel resultModel = JobModel.fromJob(showResponse.job);
        print(resultModel.toJson());

        JobListResponse clientJobsResponse = await jobRemoteDataSource.listClientJobs(cur.clientId);
        expect((clientJobsResponse != null), true);
        if (clientJobsResponse.exception != null) {
          print('clientJobsResponse.exception: ' + clientJobsResponse.exception.toString());
        }
        expect((clientJobsResponse.exception == null), true);
        expect((clientJobsResponse.jobs != null), true);

        if (cur.traderId != null && cur.traderId > 0) {
          JobListResponse traderJobsResponse = await jobRemoteDataSource.listTraderJobs(cur.traderId);
          expect((clientJobsResponse != null), true);
          if (clientJobsResponse.exception != null) {
            print('clientJobsResponse.exception: ' + clientJobsResponse.exception.toString());
          }
          expect((clientJobsResponse.exception == null), true);
          expect((clientJobsResponse.jobs != null), true);
        }
      }

      //var largestGeekValue = userList.fold(userList[0].id, (previous, current) => previous > current ? previous : current);
      //print('largestGeekValue: ' + largestGeekValue);
    });
  });

  /*group('Delete Last And First Job Data', () {
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
  });*/

}