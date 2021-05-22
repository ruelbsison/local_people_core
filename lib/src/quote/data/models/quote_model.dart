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
  String labour;
  String materials;
  String totalCost;
  String depositRequired;
  int deliveryTime;
  int traderId;
  int jobId;

  QuoteModel(
      {
        this.id,
        this.details,
        this.labour,
        this.materials,
        this.totalCost,
        this.depositRequired,
        this.deliveryTime,
        this.traderId,
        this.jobId});

  @override
  List<Object> get props => [id, details, labour, materials, totalCost, depositRequired, deliveryTime, traderId, jobId];

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
