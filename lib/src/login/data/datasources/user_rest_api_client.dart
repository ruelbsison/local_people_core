import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../models/user_model.dart';
import '../models/response_data_model.dart';
//import '../../../core/network/server_response.dart';

 part 'user_rest_api_client.g.dart';

class UserRestApi {
  static const String users = '/users';

  static const String usersWithId = '/users/{id}';
}

@RestApi(baseUrl: "http://localhost:3001/api/v1/")
abstract class UserRestApiClient {
  factory UserRestApiClient(Dio dio, {String baseUrl}) = _UserRestApiClient;

  @GET(UserRestApi.users)
  //Future<Response> listUsers();
  Future<List<UserModel>> listUsers();

  @POST(UserRestApi.users)
  Future<UserModel> createUser(@Path("id") int id, @Body() UserModel user);

  @GET(UserRestApi.usersWithId)
  //Future<Response> showUser(String id);
  Future<UserModel> showUser(@Path("id") int id);

  @PATCH(UserRestApi.usersWithId)
  Future<UserModel> updateUser(@Path("id") int id, @Body() UserModel user);

  @DELETE(UserRestApi.usersWithId)
  Future<void> deleteUser(@Path("id") int id);
}





