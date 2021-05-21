import '../../domain/entities/quote.dart';

class QuoteModel {
  String details;
  String labour;
  String materials;
  String totalCost;
  String depositRequired;
  int deliveryTime;
  int traderId;
  int jobId;

  QuoteModel(
      {this.details,
        this.labour,
        this.materials,
        this.totalCost,
        this.depositRequired,
        this.deliveryTime,
        this.traderId,
        this.jobId});

  QuoteModel.fromJson(Map<String, dynamic> json) {
    details = json['details'];
    labour = json['labour'];
    materials = json['materials'];
    totalCost = json['total_cost'];
    depositRequired = json['deposit_required'];
    deliveryTime = json['delivery_time'];
    traderId = json['trader_id'];
    jobId = json['job_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['details'] = this.details;
    data['labour'] = this.labour;
    data['materials'] = this.materials;
    data['total_cost'] = this.totalCost;
    data['deposit_required'] = this.depositRequired;
    data['delivery_time'] = this.deliveryTime;
    data['trader_id'] = this.traderId;
    data['job_id'] = this.jobId;
    return data;
  }
}
