import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/quote_request_model.dart';
import '../../../core/configs/rest_api_config.dart';
import 'package:retrofit/http.dart';

part 'quote_request_rest_api_client.g.dart';

@RestApi(baseUrl: "http://localhost:3001/api/v1/")
abstract class QuoteRequestRestApiClient {
  factory QuoteRequestRestApiClient(Dio dio, {String baseUrl}) = _QuoteRequestRestApiClient;

  @GET(RestAPIConfig.quoteRequestWithTraderId)
  Future<List<QuoteRequestModel>> listTraderQuoteRequests(@Path("id") int trader_id);

  @GET(RestAPIConfig.quoteRequestWithJobId)
  Future<List<QuoteRequestModel>> listJobQuoteRequests(@Path("id") int job_id);

  @POST(RestAPIConfig.quoteRequest)
  Future<QuoteRequestModel> createQuoteRequest(@Body() QuoteRequestModel quote);

  @GET(RestAPIConfig.quoteRequestWithId)
  Future<QuoteRequestModel> showQuoteRequest(@Path("id") int id);

  @PATCH(RestAPIConfig.quoteRequestWithId)
  Future<QuoteRequestModel> updateQuoteRequest(@Path("id") int id, @Body() QuoteRequestModel job);

  @DELETE(RestAPIConfig.quoteRequestWithId)
  Future<void> deleteQuoteRequest(@Path("id") int id);
}