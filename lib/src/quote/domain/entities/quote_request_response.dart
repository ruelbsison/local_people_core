import 'quote_request.dart';
import '../../data/models/quote_request_model.dart';

class QuoteRequestResponse {
  Exception exception;
  QuoteRequest quoteRequest;

  void fromModel(QuoteRequestModel model) {
    quoteRequest = QuoteRequest(
        id: model.id,
        message: model.message,
        traderId: model.traderId,
        clientId: model.clientId,
        jobId: model.jobId,
        createdAt: model.createdAt,
        updatedAt: model.updatedAt,
    );
  }

  static QuoteRequestModel fromQuoteRequest(QuoteRequest quoteRequest) {
    return QuoteRequestModel (
      id: quoteRequest.id,
      message: quoteRequest.message,
      traderId: quoteRequest.traderId,
      clientId: quoteRequest.clientId,
      jobId: quoteRequest.jobId,
      createdAt: quoteRequest.createdAt,
      updatedAt: quoteRequest.updatedAt,
    );
  }
}
