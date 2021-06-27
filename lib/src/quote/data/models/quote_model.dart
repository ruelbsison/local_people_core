import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quote_model.g.dart';

/// {@template QuoteModel}
/// QuoteModel model
///
/// [QuoteModel.empty] represents an unauthenticated QuoteModel.
/// {@endtemplate}
@JsonSerializable()
class QuoteModel extends Equatable {
  int id;
  String details;
  int duration_required;
  String labour;
  String materials;
  String total_cost;
  String deposit_required;
  String delivery_date;
  int trader_id;
  int job_id;

  QuoteModel(
      {
        this.id,
        this.duration_required,
        this.details,
        this.labour,
        this.materials,
        this.total_cost,
        this.deposit_required,
        this.delivery_date,
        this.trader_id,
        this.job_id});

  @override
  List<Object> get props => [id, duration_required, details, labour,
    materials, total_cost, deposit_required, delivery_date, trader_id, job_id];

  factory QuoteModel.fromJson(Map<String, dynamic> json) => _$QuoteModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuoteModelToJson(this);

  // QuoteModel.fromJson(Map<String, dynamic> json) {
  //   details = json['details'];
  //   labour = json['labour'];
  //   materials = json['materials'];
  //   totalCost = json['total_cost'];
  //   depositRequired = json['deposit_required'];
  //   deliveryTime = json['delivery_time'];
  //   traderId = json['trader_id'];
  //   jobId = json['job_id'];
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['details'] = this.details;
  //   data['labour'] = this.labour;
  //   data['materials'] = this.materials;
  //   data['total_cost'] = this.totalCost;
  //   data['deposit_required'] = this.depositRequired;
  //   data['delivery_time'] = this.deliveryTime;
  //   data['trader_id'] = this.traderId;
  //   data['job_id'] = this.jobId;
  //   return data;
  // }
}
