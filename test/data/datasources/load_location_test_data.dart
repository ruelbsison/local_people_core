import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
//import 'package:test/test.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/jobs.dart';
import '../../res/locations_test_data.dart';

class MockRemoteDataSource extends Mock implements LocationRemoteDataSource {}

void main() {
  LocationRemoteDataSource locationRemoteDataSource;
  MockRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    LocationRestApiClient locationRestApiClient = LocationRestApiClient(
      RestAPIConfig.getDioOptions(),
      baseUrl: RestAPIConfig().baseURL,
    );
    locationRemoteDataSource =
        LocationRemoteDataSourceImpl(locationRestApiClient: locationRestApiClient);
  });

  group('Load Test Location Date, Create The Location Data', () {
    test('Location Should Be Created Successfully', () async {
      var listIterator = testLocations.iterator;
      while( listIterator.moveNext() ) {
        Location location = listIterator.current;
        LocationModel model = LocationModel.fromLocation(location);
        print(model.toJson());
        var temp = model.toJson();
        temp.keys
            .where((k) => temp[k] == null) // filter keys
            .toList() // create a copy to avoid concurrent modifications
            .forEach(temp.remove); // remove selected keys
        print(temp);

        LocationResponse response = await locationRemoteDataSource.createLocation(model);
        expect((response != null), true);

        if (response.exception != null) {
          print('response.exception: ' + response.exception.toString());
        }
        expect((response.exception == null), true);

        expect((response.location != null), true);
        LocationModel resultModel = LocationModel.fromLocation(response.location);
        print(resultModel.toJson());
      }
    });
  });
}