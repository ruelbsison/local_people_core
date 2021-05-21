import 'quote_request.dart';
import '../../data/models/quote_request_model.dart';

class QuoteRequestListResponse {
  Exception exception;
  List<QuoteRequest> quotes;

  void fromModel(List<QuoteRequestModel> models) {
    quotes = List<QuoteRequest>();
    var listIter = models.iterator;
    while (listIter.moveNext()) {
      QuoteRequestModel model = listIter.current;
      QuoteRequest quote = QuoteRequest(
        id: model.id,
        message: model.message,
        traderId: model.traderId,
        clientId: model.clientId,
        jobId: model.jobId,
        createdAt: model.createdAt,
        updatedAt: model.updatedAt,
      );
      quotes.add(quote);
    }
  }
}
