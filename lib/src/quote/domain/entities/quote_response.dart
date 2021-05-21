
import 'quote.dart';
import '../../data/models/quote_model.dart';

class QuoteResponse {
  Exception exception;
  Quote quote;

  void fromModel(QuoteModel model) {
    quote = Quote(
      labour: model.labour,
      materials: model.materials,
      totalCost: model.totalCost,
      depositRequired: model.depositRequired,
      deliveryTime: model.deliveryTime,
      traderId: model.traderId,
      jobId: model.jobId,
    );
  }

  static QuoteModel fromQuote(Quote quote) {
    return QuoteModel (
      labour: quote.labour,
      materials: quote.materials,
      totalCost: quote.totalCost,
      depositRequired: quote.depositRequired,
      deliveryTime: quote.deliveryTime,
      traderId: quote.traderId,
      jobId: quote.jobId,
    );
  }
}
