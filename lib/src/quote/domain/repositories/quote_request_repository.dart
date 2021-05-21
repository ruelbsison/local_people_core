import '../entities/quote_request.dart';
import '../entities/quote_request_response.dart';
import '../entities/quote_request_list_response.dart';

abstract class QuoteRequestRepository {
  Future<QuoteRequestListResponse> listTraderQuoteRequests(int trader_id);

  Future<QuoteRequestListResponse> listJobQuoteRequests(int job_id);

  Future<QuoteRequestResponse> createQuoteRequest(QuoteRequest quote);

  Future<QuoteRequestResponse> showQuoteRequest(int id);

  Future<QuoteRequestResponse> updateQuoteRequest( QuoteRequest quote);

  Future<Exception> deleteQuoteRequest(int id);
}