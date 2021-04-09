import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../models/user_model.dart';
import '../models/response_data_model.dart';
import '../../../core/configs/rest_api_config.dart';

part 'client_rest_api_client.g.dart';

@RestApi(baseUrl: "http://localhost:3001/api/v1/")
abstract class ClientRestApiClient {
  factory ClientRestApiClient(Dio dio, {String baseUrl}) = _ClientRestApiClient;

  @GET(RestAPIConfig.client)
  //Future<Response> listUsers();
  Future<List<UserModel>> listUsers();

  @POST(RestAPIConfig.client)
  Future<UserModel> createUser(@Path("id") int id, @Body() UserModel user);

  @GET(RestAPIConfig.clientWithId)
  //Future<Response> showUser(String id);
  Future<UserModel> showUser(@Path("id") int id);

  @PATCH(RestAPIConfig.clientWithId)
  Future<UserModel> updateUser(@Path("id") int id, @Body() UserModel user);

  @DELETE(RestAPIConfig.clientWithId)
  Future<void> deleteUser(@Path("id") int id);
}





