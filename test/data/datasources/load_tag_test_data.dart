import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
//import 'package:test/test.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/jobs.dart';
import '../../res/tags_test_data.dart';

class MockRemoteDataSource extends Mock implements TagRemoteDataSource {}

void main() {
  TagRemoteDataSource tagRemoteDataSource;
  MockRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    TagRestApiClient tagRestApiClient = TagRestApiClient(
      RestAPIConfig.getDioOptions(),
      baseUrl: RestAPIConfig().baseURL,
    );
    tagRemoteDataSource =
        TagRemoteDataSourceImpl(tagRestApiClient: tagRestApiClient);
  });

  group('Load Test Tag Date, Create The Tag Data', () {
    test('Tag Should Be Created Successfully', () async {
      var listIterator = testTags.iterator;
      while( listIterator.moveNext() ) {
        Tag tag = listIterator.current;
        TagModel model = TagModel.fromTag(tag);
        print(model.toJson());

        TagResponse response = await tagRemoteDataSource.createTag(model);
        expect((response != null), true);

        if (response.exception != null) {
          print('response.exception: ' + response.exception.toString());
        }
        expect((response.exception == null), true);

        expect((response.tag != null), true);
        TagModel resultModel = TagModel.fromTag(response.tag);
        print(resultModel.toJson());
      }
    });
  });
}