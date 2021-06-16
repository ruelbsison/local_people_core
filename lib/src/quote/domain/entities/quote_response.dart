
import 'quote.dart';
import '../../data/models/quote_model.dart';

class QuoteResponse {
  Exception exception;
  Quote quote;

  void fromModel(QuoteModel model) {
    quote = Quote(
      dureationRequired: model.duration_required,
      labour: model.labour,
      materials: model.materials,
      totalCost: model.totalCost,
      depositRequired: model.deposit_required,
      deliveryDate: DateTime.parse(model.delivery_date),
      traderId: model.trader_id,
      jobId: model.job_id,
    );
  }

  static QuoteModel fromQuote(Quote quote) {
    return QuoteModel (
      duration_required: quote.dureationRequired,
      labour: quote.labour,
      materials: quote.materials,
      totalCost: quote.totalCost,
      deposit_required: quote.depositRequired,
      delivery_date: quote.deliveryDate.toString(),
      trader_id: quote.traderId,
      job_id: quote.jobId,
    );
  }
}
