import 'quote.dart';
import '../../data/models/quote_model.dart';

class QuoteListResponse {
  Exception exception;
  List<Quote> quotes;

  void fromModel(List<QuoteModel> models) {
    quotes = List<Quote>();
    var listIter = models.iterator;
    while (listIter.moveNext()) {
      QuoteModel model = listIter.current;
      Quote quote = Quote(
        labour: model.labour,
        materials: model.materials,
        totalCost: model.totalCost,
        depositRequired: model.depositRequired,
        deliveryTime: model.deliveryTime,
        traderId: model.traderId,
        jobId: model.jobId,
      );
      quotes.add(quote);
    }
  }
}
