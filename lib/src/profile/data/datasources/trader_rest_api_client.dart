import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../models/trader_model.dart';
import '../../../core/configs/rest_api_config.dart';

part 'trader_rest_api_client.g.dart';

@RestApi(baseUrl: "http://localhost:3001/api/v1/")
abstract class TraderRestApiClient {
  factory TraderRestApiClient(Dio dio, {String baseUrl}) = _TraderRestApiClient;

  @GET(RestAPIConfig.trader)
  //Future<Response> listTraders();
  Future<List<TraderModel>> listTraders();

  @GET(RestAPIConfig.traderTopRated)
  //Future<Response> listTraders();
  Future<List<TraderModel>> listTopRatedTraders();

  @POST(RestAPIConfig.trader)
  Future<TraderModel> createTrader(@Body() Map<String, Map<String, dynamic>> model);

  @GET(RestAPIConfig.traderWithId)
  //Future<Response> showTrader(String id);
  Future<TraderModel> showTrader(@Path("id") int id);

  @PATCH(RestAPIConfig.traderWithId)
  Future<TraderModel> updateTrader(@Path("id") int id, @Body() Map<String, Map<String, dynamic>> model);

  @GET(RestAPIConfig.traderWithEmail)
  Future<TraderModel> findTraderWithEmail(@Path("email") String email);

  @DELETE(RestAPIConfig.traderWithId)
  Future<void> deleteTrader(@Path("id") int id);
}





