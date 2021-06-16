import 'quote_request.dart';
import '../../data/models/quote_request_model.dart';

class QuoteRequestListResponse {
  Exception exception;
  List<QuoteRequest> quoteRequests;

  void fromModel(List<QuoteRequestModel> models) {
    quoteRequests = List<QuoteRequest>();
    var listIter = models.iterator;
    while (listIter.moveNext()) {
      QuoteRequestModel model = listIter.current;
      QuoteRequest quote = QuoteRequest(
        id: model.id,
        message: model.message,
        traderId: model.trader_id,
        clientId: model.client_id,
        jobId: model.job_id,
        createdAt: model.created_at,
        updatedAt: model.updated_at,
      );
      quoteRequests.add(quote);
    }
  }
}
