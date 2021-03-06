
import 'quote.dart';
import '../../data/models/quote_model.dart';

class QuoteResponse {
  Exception exception;
  Quote quote;

  void fromModel(QuoteModel model) {
    quote = Quote(
      id: model.id,
      dureationRequired: model.duration_required,
      labour: model.labour,
      materials: model.materials,
      totalCost: model.total_cost,
      depositRequired: model.deposit_required,
      deliveryDate: DateTime.parse(model.delivery_date),
      traderId: model.trader_id,
      jobId: model.job_id,
      createdAt: DateTime.parse(model.created_at),
    );
  }

  static QuoteModel fromQuote(Quote quote) {
    return QuoteModel (
      id: quote.id,
      duration_required: quote.dureationRequired,
      labour: quote.labour,
      materials: quote.materials,
      total_cost: quote.totalCost,
      deposit_required: quote.depositRequired,
      delivery_date: quote.deliveryDate.toString(),
      trader_id: quote.traderId,
      job_id: quote.jobId,
      created_at: quote.createdAt.toString(),
    );
  }
}
