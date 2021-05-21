import '../models/quote_model.dart';
import '../../domain/entities/quote_list_response.dart';
import '../../domain/entities/quote_response.dart';

abstract class QuoteRemoteDataSource {
  Future<QuoteListResponse> listTraderQuotes(int trader_id);

  Future<QuoteListResponse> listJobQuotes(int job_id);

  Future<QuoteResponse> createQuote(QuoteModel quote);

  Future<QuoteResponse> showQuote(int id);

  Future<QuoteResponse> updateQuote(QuoteModel job);

  Future<void> deleteQuote(int id);
}