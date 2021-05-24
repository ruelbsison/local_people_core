import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
//import 'package:test/test.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/jobs.dart';
import '../../res/jobs_test_data.dart';
import 'dart:convert';

class MockRemoteDataSource extends Mock implements JobRemoteDataSource {}

void main() {
  JobRemoteDataSource jobRemoteDataSource;
  MockRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    JobRestApiClient jobRestApiClient = JobRestApiClient(
      RestAPIConfig.getDioOptions(),
      baseUrl: RestAPIConfig().baseURL,
    );
    jobRemoteDataSource =
        JobRemoteDataSourceImpl(jobRestApiClient: jobRestApiClient);
  });

  group('Load Test Job Date, Create The Job Data', () {
    test('Job Should Be Created Successfully', () async {

      // JobResponse response = JobResponse();
      // String json =' {"id":4,"title":"Job request name or description","description":"Short job description preview, job description preview, short job description preview, job description preview.","date":"2021-05-23T16:45:44.454Z","budget":"500.0","awarded":false,"created_at":"2021-05-23T08:45:45.454Z","updated_at":"2021-05-23T08:45:45.454Z","client_id":5,"trader_id":null,"location_id":null,"category_id":null,"duration":null,"tags":[],"images":[]}';
      // response.jobFromModel(JobModel.fromJson(jsonDecode(json)));
      // expect((response.job != null), true);

      var listIterator = testJobs.iterator;
      while( listIterator.moveNext() ) {
        Job job = listIterator.current;
        JobModel model = JobModel.fromJob(job);
        print(model.toJson());

        JobResponse response = await jobRemoteDataSource.createJob(model, job.images);
        expect((response != null), true);

        if (response.exception != null) {
          print('response.exception: ' + response.exception.toString());
        }
        expect((response.exception == null), true);

        expect((response.job != null), true);
        JobModel resultModel = JobModel.fromJob(response.job);
        print(resultModel.toJson());
      }
    });
  });
}