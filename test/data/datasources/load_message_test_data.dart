import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
//import 'package:test/test.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/messages.dart';
import '../../res/messages_test_data.dart';

class MockRemoteDataSource extends Mock implements MessageRemoteDataSource {}

void main() {
  MessageRemoteDataSource messageRemoteDataSource;
  MockRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    MessageRestApiClient messageRestApiClient = MessageRestApiClient(
      RestAPIConfig.getDioOptions(),
      baseUrl: RestAPIConfig().baseURL,
    );
    messageRemoteDataSource =
        MessageRemoteDataSourceImpl(messageRestApiClient: messageRestApiClient);
  });

  group('Load Test Message Date, Create The Message Data', () {
    test('Message Should Be Created Successfully', () async {
      var listIterator = testMessages.iterator;
      while( listIterator.moveNext() ) {
        Message message = listIterator.current;
        MessageModel model = MessageModel.fromMessage(message);
        print(model.toJson());

        var temp = model.toJson();
        temp.keys
            .where((k) => temp[k] == null) // filter keys
            .toList() // create a copy to avoid concurrent modifications
            .forEach(temp.remove); // remove selected keys
        print(temp);

        MessageResponse response = await messageRemoteDataSource.createMessage(model);
        expect((response != null), true);

        if (response.exception != null) {
          print('response.exception: ' + response.exception.toString());
        }
        expect((response.exception == null), true);

        expect((response.message != null), true);
        MessageModel resultModel = MessageModel.fromMessage(response.message);
        print(resultModel.toJson());
      }
    });
  });
}