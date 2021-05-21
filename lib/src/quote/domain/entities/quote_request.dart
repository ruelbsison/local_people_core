import 'package:equatable/equatable.dart';

class QuoteRequest extends Equatable {
  int id;
  String message;
  int traderId;
  int clientId;
  int jobId;
  String createdAt;
  String updatedAt;

  QuoteRequest({this.id,
    this.message,
    this.traderId,
    this.clientId,
    this.jobId,
    this.createdAt,
    this.updatedAt});

  @override
  List<Object> get props => [id, message, traderId, clientId, jobId, createdAt, updatedAt];

}