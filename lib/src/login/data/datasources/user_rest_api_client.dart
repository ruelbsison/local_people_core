import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../models/user_model.dart';
import '../models/response_data_model.dart';

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
  Future<ResponseDataModel> createUser();

  @GET(UserRestApi.usersWithId)
  //Future<Response> showUser(String id);
  Future<UserModel> showUser(String id);

  @PATCH(UserRestApi.usersWithId)
  Future<ResponseDataModel> updateUser(String id);

  @DELETE(UserRestApi.usersWithId)
  Future<ResponseDataModel> deleteUser(String id);
}





