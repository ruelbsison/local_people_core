import 'package:equatable/equatable.dart';

class Quote extends Equatable {
  int id;
  String details;
  String labour;
  String materials;
  String totalCost;
  String depositRequired;
  int deliveryTime;
  int traderId;
  int jobId;

  Quote({this.id,
    this.details,
    this.labour,
    this.materials,
    this.totalCost,
    this.depositRequired,
    this.deliveryTime,
    this.traderId,
    this.jobId});

  @override
  List<Object> get props => [id, details, labour, materials,
    totalCost, depositRequired, deliveryTime, traderId, jobId];

}