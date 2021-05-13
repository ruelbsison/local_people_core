import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/login.dart';
//import 'package:local_people_core/src/login/data/datasources/user_rest_api_client.dart';
import 'package:local_people_core/src/profile/data/datasources/client_rest_api_client.dart';
import 'package:local_people_core/src/profile/data/datasources/trader_rest_api_client.dart';
import 'package:mockito/mockito.dart';

class MockUserRestApiClient extends Mock implements UserRestApiClient {}

void main() {
  ClientRestApiClient userRestApiClient;
  MockUserRestApiClient mockUserRestApiClient;

  setUp(() {
    mockUserRestApiClient = MockUserRestApiClient();
    userRestApiClient = ClientRestApiClient(RestAPIConfig.getDioOptions());
  });

  // group('Given User Models, Create The User Data', () {
  //   test('User Should Be Created Successfully', () async {
  //
  //     List<UserModel> userList = await userRestApiClient.listUsers();
  //     UserModel gmailUser = UserModel(
  //       id: 0,
  //       name: "Ruel Sison",
  //       email: "rsjudge17@gmail.com",
  //       token: "Zhdhsjj127bsjbjnj",
  //       token_expiration_date: "2021-03-31T16:39:33.834Z",
  //     );
  //     // 1
  //     gmailUser = await userRestApiClient.createUser(gmailUser.id, gmailUser);
  //     // 2
  //     expect((gmailUser.id > 0), true);
  //     // 3
  //     expect(gmailUser.created_at.length, 24);
  //     expect(gmailUser.updated_at.length, 24);
  //
  //     UserModel hotmailUser = UserModel(
  //       id: 0,
  //       name: "Ruel Sison",
  //       email: "rsjudge17@hotmail.com",
  //       token: "Ahdhsjj127bsjbjnj",
  //       token_expiration_date: "2021-03-31T16:39:33.834Z",
  //     );
  //
  //     // 1
  //     hotmailUser = await userRestApiClient.createUser(hotmailUser.id, hotmailUser);
  //     // 2
  //     expect((hotmailUser.id > 0), true);
  //     // 3
  //     expect(hotmailUser.created_at.length, 24);
  //     expect(hotmailUser.updated_at.length, 24);
  //
  //     List<UserModel> userListWithNew = await userRestApiClient.listUsers();
  //     expect(userListWithNew.length, userList.length + 2);
  //   });
  // });

  // group('List User, Update User Token Data', () {
  //   test('User Should Be Updated Successfully', () async {
  //
  //     List<UserModel> userList = await userRestApiClient.listUsers();
  //     var userListIter = userList.iterator;
  //     while( userListIter.moveNext() ) {
  //       print(userListIter.current.toJson());
  //
  //       UserModel cur = userListIter.current;
  //       int tokenLen = cur.token.length;
  //       cur.token = cur.token + 'A';
  //
  //       UserModel updatedUserModel = await userRestApiClient.updateUser(cur.id, cur);
  //       print(updatedUserModel.toJson());
  //       expect(updatedUserModel.id, cur.id);
  //       expect(updatedUserModel.token.length , tokenLen + 1);
  //     }
  //
  //   });
  // });

  // group('List User, Show User Data', () {
  //   test('User Should Be Shown Successfully', () async {
  //
  //     List<UserModel> userList = await userRestApiClient.listUsers();
  //     var userListIter = userList.iterator;
  //     while( userListIter.moveNext() ) {
  //       UserModel cur = userListIter.current;
  //       print(cur.toJson());
  //
  //       UserModel showUserModel = await userRestApiClient.showUser(cur.id);
  //       print(showUserModel.toJson());
  //       expect(showUserModel.id, cur.id);
  //       expect(showUserModel.name , cur.name);
  //       expect(showUserModel.email , cur.email);
  //       expect(showUserModel.token , cur.token);
  //       expect(showUserModel.token_expiration_date , cur.token_expiration_date);
  //       expect(showUserModel.created_at , cur.created_at);
  //       expect(showUserModel.updated_at , cur.updated_at);
  //     }
  //
  //     //var largestGeekValue = userList.fold(userList[0].id, (previous, current) => previous > current ? previous : current);
  //     //print('largestGeekValue: ' + largestGeekValue);
  //   });
  // });

  // group('Delete Last And First User Data', () {
  //   test('User Should Be Deleted Successfully', () async {
  //
  //     List<UserModel> userList = await userRestApiClient.listUsers();
  //     UserModel cur = userList.last;
  //     await userRestApiClient.deleteUser(cur.id);
  //     //ResponseDataModel responseDataModel = await userRestApiClient.deleteUser(cur.id);
  //     //expect(responseDataModel.code, 204);
  //
  //
  //     cur = userList.first;
  //     await userRestApiClient.deleteUser(cur.id);
  //     //responseDataModel = await userRestApiClient.deleteUser(cur.id);
  //     //expect(responseDataModel.code, 204);
  //   });
  // });

}