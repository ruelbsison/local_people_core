import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/message_model.dart';
import '../../../core/configs/rest_api_config.dart';
import 'package:retrofit/http.dart';

part 'message_rest_api_client.g.dart';

@RestApi(baseUrl: "http://localhost:3001/api/v1/")
abstract class MessageRestApiClient {
  factory MessageRestApiClient(Dio dio, {String baseUrl}) = _MessageRestApiClient;

  @GET(RestAPIConfig.messageWithClientId)
  Future<List<MessageModel>> listClientMessages(@Path("id") int client_id);

  @GET(RestAPIConfig.messageWithTraderId)
  Future<List<MessageModel>> listTraderMessages(@Path("id") int trader_id);

  @GET(RestAPIConfig.messageWithJobId)
  Future<List<MessageModel>> listJobMessages(@Path("id") int job_id);

  @POST(RestAPIConfig.message)
  Future<MessageModel> createMessage(@Body() MessageModel message);

  @GET(RestAPIConfig.messageWithId)
  Future<MessageModel> showMessage(@Path("id") int id);

  @PATCH(RestAPIConfig.messageWithId)
  Future<MessageModel> updateMessage(@Path("id") int id, @Body() MessageModel job);

  @DELETE(RestAPIConfig.messageWithId)
  Future<void> deleteMessage(@Path("id") int id);
}