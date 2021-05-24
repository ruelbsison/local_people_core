import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../models/client_model.dart';
import '../../../core/configs/rest_api_config.dart';

part 'client_rest_api_client.g.dart';

@RestApi(baseUrl: "http://localhost:3001/api/v1/")
abstract class ClientRestApiClient {
  factory ClientRestApiClient(Dio dio, {String baseUrl}) = _ClientRestApiClient;

  @GET(RestAPIConfig.client)
  //Future<Response> listClients();
  Future<List<ClientModel>> listClients();

  @POST(RestAPIConfig.client)
  Future<ClientModel> createClient(@Body() Map<String, Map<String, dynamic>> client);

  @GET(RestAPIConfig.clientWithId)
  //Future<Response> showClient(String id);
  Future<ClientModel> showClient(@Path("id") int id);

  @PATCH(RestAPIConfig.clientWithId)
  Future<ClientModel> updateClient(@Path("id") int id, @Body() Map<String, Map<String, dynamic>> client);

  @GET(RestAPIConfig.clientWithEmail)
  Future<ClientModel> findClientWithEmail(@Path("email") String email);

  @DELETE(RestAPIConfig.clientWithId)
  Future<void> deleteClient(@Path("id") int id);
}





