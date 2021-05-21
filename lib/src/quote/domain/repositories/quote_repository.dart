
import '../entities/quote.dart';
import '../entities/quote_response.dart';
import '../entities/quote_list_response.dart';

abstract class QuoteRepository {
  Future<QuoteListResponse> listTraderQuotes(int trader_id);

  Future<QuoteListResponse> listJobQuotes(int job_id);

  Future<QuoteResponse> createQuote(Quote quote);

  Future<QuoteResponse> showQuote(int id);

  Future<QuoteResponse> updateQuote(Quote quote);

  Future<Exception> deleteQuote(int id);
}