import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quote_request_model.g.dart';

@JsonSerializable()
class QuoteRequestModel extends Equatable {
  int id;
  String message;
  int trader_id;
  int client_id;
  int job_id;
  String created_at;
  String updated_at;

  QuoteRequestModel(
      {this.id,
        this.message,
        this.trader_id,
        this.client_id,
        this.job_id,
        this.created_at,
        this.updated_at});

  @override
  List<Object> get props => [id, message, trader_id, client_id, job_id, created_at, updated_at];

  factory QuoteRequestModel.fromJson(Map<String, dynamic> json) => _$QuoteRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuoteRequestModelToJson(this);
  // QuoteRequestModel.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   message = json['message'];
  //   traderId = json['trader_id'];
  //   clientId = json['client_id'];
  //   jobId = json['job_id'];
  //   createdAt = json['created_at'];
  //   updatedAt = json['updated_at'];
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['message'] = this.message;
  //   data['trader_id'] = this.traderId;
  //   data['client_id'] = this.clientId;
  //   data['job_id'] = this.jobId;
  //   data['created_at'] = this.createdAt;
  //   data['updated_at'] = this.updatedAt;
  //   return data;
  // }
}
