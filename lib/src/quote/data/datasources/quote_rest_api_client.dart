//import 'package:http/http.dart';
import 'package:retrofit/retrofit.dart';
import '../models/quote_model.dart';
import '../../../core/configs/rest_api_config.dart';
import 'package:retrofit/http.dart';

part 'quote_rest_api_client.g.dart';

@RestApi(baseUrl: "http://localhost:3001/api/v1/")
abstract class QuoteRestApiClient {
  factory QuoteRestApiClient(Dio dio, {String baseUrl}) = _QuoteRestApiClient;

  @GET(RestAPIConfig.quoteWithTraderId)
  Future<List<QuoteModel>> listTraderQuotes(@Path("id") int trader_id);

  @GET(RestAPIConfig.quoteWithJobId)
  Future<List<QuoteModel>> listJobQuotes(@Path("id") int job_id);

  @POST(RestAPIConfig.quote)
  Future<QuoteModel> createQuote(@Body() QuoteModel quote);

  @GET(RestAPIConfig.quoteWithId)
  Future<QuoteModel> showQuote(@Path("id") int id);

  @PATCH(RestAPIConfig.quoteWithId)
  Future<QuoteModel> updateQuote(@Path("id") int id, @Body() QuoteModel job);

  @DELETE(RestAPIConfig.quoteWithId)
  Future<void> deleteQuote(@Path("id") int id);
}