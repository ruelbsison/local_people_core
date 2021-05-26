import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
//import 'package:test/test.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/profile.dart';
import '../../res/profile_test_data.dart';

class MockRemoteDataSource extends Mock
    implements ClientRemoteDataSource, TraderRemoteDataSource {}

void main() {
  ClientRemoteDataSource clientRemoteDataSource;
  TraderRemoteDataSource traderRemoteDataSource;
  MockRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    ClientRestApiClient clientRestApiClient = ClientRestApiClient(
      RestAPIConfig.getDioOptions(),
      baseUrl: RestAPIConfig().baseURL,
    );
    clientRemoteDataSource =
        ClientRemoteDataSourceImpl(clientRestApiClient: clientRestApiClient);
    TraderRestApiClient traderRestApiClient = TraderRestApiClient(
      RestAPIConfig.getDioOptions(),
      baseUrl: RestAPIConfig().baseURL,
    );
    traderRemoteDataSource =
        TraderRemoteDataSourceImpl(traderRestApiClient: traderRestApiClient);
  });

  // group('Load Test Profile Date, Create ClientProfile Tag Data', () {
  //   test('ClientProfile Should Be Created Successfully', () async {
  //     var listIterator = testClientProfiles.iterator;
  //     while( listIterator.moveNext() ) {
  //       ClientProfile profile = listIterator.current;
  //       ClientModel model = ClientModel.fromClientProfile(profile);
  //       print(model.toJson());
  //
  //       ClientResponse response = await clientRemoteDataSource.createClient(model);
  //       expect((response != null), true);
  //
  //       if (response.exception != null) {
  //         print('response.exception: ' + response.exception.toString());
  //       }
  //       expect((response.exception == null), true);
  //
  //       expect((response.profile != null), true);
  //       ClientModel resultModel = ClientModel.fromClientProfile(response.profile);
  //       print(resultModel.toJson());
  //     }
  //   });
  // });
  //
  // group('Load Test Profile Date, Create TraderProfile Tag Data', () {
  //   test('TraderProfile Should Be Created Successfully', () async {
  //     var listIterator = testTraderProfiles.iterator;
  //     while( listIterator.moveNext() ) {
  //       TraderProfile profile = listIterator.current;
  //       TraderModel model = TraderModel.fromTraderProfile(profile);
  //       print(model.toJson());
  //
  //       TraderResponse response = await traderRemoteDataSource.createTrader(model);
  //       expect((response != null), true);
  //
  //       if (response.exception != null) {
  //         print('response.exception: ' + response.exception.toString());
  //       }
  //       expect((response.exception == null), true);
  //
  //       expect((response.profile != null), true);
  //       TraderModel resultModel = TraderModel.fromTraderProfile(response.profile);
  //       print(resultModel.toJson());
  //     }
  //   });
  // });

  group('List Profiles, Show Profile Data', () {
    test('Profile Should Be Shown Successfully', () async {
      ClientListResponse response = await clientRemoteDataSource.listClients();
      expect((response != null), true);
      if (response.exception != null) {
        print('response.exception: ' + response.exception.toString());
      }
      expect((response.exception == null), true);
      expect((response.profiles != null), true);

      var listIterator = response.profiles.iterator;
      while (listIterator.moveNext()) {
        ClientProfile profile = listIterator.current;

        ClientResponse response =
            await clientRemoteDataSource.showClient(profile.id);
        expect((response != null), true);
        if (response.exception != null) {
          print('response.exception: ' + response.exception.toString());
        }
        expect((response.exception == null), true);
        expect((response.profile != null), true);

        ClientModel resultModel =
            ClientModel.fromClientProfile(response.profile);
        print(resultModel.toJson());
      }
    });
  });

  group('List TraderProfile, Show TraderProfile Data', () {
    test('TraderProfile Should Be Shown Successfully', () async {
      TraderListResponse response = await traderRemoteDataSource.listTraders();
      expect((response != null), true);
      if (response.exception != null) {
        print('response.exception: ' + response.exception.toString());
      }
      expect((response.exception == null), true);
      expect((response.profiles != null), true);

      var listIterator = response.profiles.iterator;
      while (listIterator.moveNext()) {
        TraderProfile profile = listIterator.current;

        TraderResponse showResponse =
            await traderRemoteDataSource.showTrader(profile.id);
        expect((showResponse != null), true);
        if (showResponse.exception != null) {
          print('showResponse.exception: ' + showResponse.exception.toString());
        }
        expect((showResponse.exception == null), true);
        expect((showResponse.profile != null), true);

        TraderModel resultModel =
            TraderModel.fromTraderProfile(showResponse.profile);
        print(resultModel.toJson());
      }
    });
  });
}
