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
  Future<ClientModel> createClient(@Path("id") int id, @Body() ClientModel client);

  @GET(RestAPIConfig.clientWithId)
  //Future<Response> showClient(String id);
  Future<ClientModel> showClient(@Path("id") int id);

  @PATCH(RestAPIConfig.clientWithId)
  Future<ClientModel> updateClient(@Path("id") int id, @Body() ClientModel client);

  @PATCH(RestAPIConfig.clientWithEmail)
  Future<ClientModel> findClientWithEmail(@Path("id") String email);

  @DELETE(RestAPIConfig.clientWithId)
  Future<void> deleteClient(@Path("id") int id);
}





