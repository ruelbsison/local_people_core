import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../models/user_model.dart';
import '../models/response_data_model.dart';
import '../../../core/configs/rest_api_config.dart';

part 'trader_rest_api_client.g.dart';

@RestApi(baseUrl: "http://localhost:3001/api/v1/")
abstract class TraderRestApiClient {
  factory TraderRestApiClient(Dio dio, {String baseUrl}) = _TraderRestApiClient;

  @GET(RestAPIConfig.trader)
  //Future<Response> listUsers();
  Future<List<UserModel>> listUsers();

  @POST(RestAPIConfig.trader)
  Future<UserModel> createUser(@Path("id") int id, @Body() UserModel user);

  @GET(RestAPIConfig.traderWithId)
  //Future<Response> showUser(String id);
  Future<UserModel> showUser(@Path("id") int id);

  @PATCH(RestAPIConfig.traderWithId)
  Future<UserModel> updateUser(@Path("id") int id, @Body() UserModel user);

  @DELETE(RestAPIConfig.traderWithId)
  Future<void> deleteUser(@Path("id") int id);
}