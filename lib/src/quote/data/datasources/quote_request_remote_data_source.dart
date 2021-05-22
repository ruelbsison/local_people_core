import '../models/quote_request_model.dart';
import '../../domain/entities/quote_request_list_response.dart';
import '../../domain/entities/quote_request_response.dart';

abstract class QuoteRequestRemoteDataSource {
  Future<QuoteRequestListResponse> listTraderQuoteRequests(int trader_id);

  Future<QuoteRequestListResponse> listJobQuoteRequests(int job_id);

  Future<QuoteRequestResponse> createQuoteRequest(QuoteRequestModel quote);

  Future<QuoteRequestResponse> showQuoteRequest(int id);

  Future<QuoteRequestResponse> updateQuoteRequest(QuoteRequestModel job);

  Future<Exception> deleteQuoteRequest(int id);
}