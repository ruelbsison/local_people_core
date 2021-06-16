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
        dureationRequired: model.duration_required,
        labour: model.labour,
        materials: model.materials,
        totalCost: model.totalCost,
        depositRequired: model.deposit_required,
        deliveryDate: DateTime.parse(model.delivery_date),
        traderId: model.trader_id,
        jobId: model.job_id,
      );
      quotes.add(quote);
    }
  }
}
