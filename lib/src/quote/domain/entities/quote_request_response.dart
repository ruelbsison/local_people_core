import 'quote_request.dart';
import '../../data/models/quote_request_model.dart';

class QuoteRequestResponse {
  Exception exception;
  QuoteRequest quoteRequest;

  void fromModel(QuoteRequestModel model) {
    quoteRequest = QuoteRequest(
        id: model.id,
        message: model.message,
        traderId: model.trader_id,
        clientId: model.client_id,
        jobId: model.job_id,
        createdAt: model.created_at,
        updatedAt: model.updated_at,
    );
  }

  static QuoteRequestModel fromQuoteRequest(QuoteRequest quoteRequest) {
    return QuoteRequestModel (
      id: quoteRequest.id,
      message: quoteRequest.message,
      trader_id: quoteRequest.traderId,
      client_id: quoteRequest.clientId,
      job_id: quoteRequest.jobId,
      created_at: quoteRequest.createdAt,
      updated_at: quoteRequest.updatedAt,
    );
  }
}
