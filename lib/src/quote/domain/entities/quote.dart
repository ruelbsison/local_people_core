import 'package:equatable/equatable.dart';
//import 'package:local_people_core/profile.dart';
//import 'package:local_people_core/jobs.dart';

class Quote extends Object {
  int id;
  String details;
  String labour;
  String materials;
  String totalCost;
  String depositRequired;
  int dureationRequired;
  DateTime deliveryDate;
  int traderId;
  int jobId;

  //Job job;
  //TraderProfile traderProfile;

  Quote({this.id,
    this.dureationRequired,
    this.details,
    this.labour,
    this.materials,
    this.totalCost,
    this.depositRequired,
    this.deliveryDate,
    this.traderId,
    this.jobId,});

  @override
  bool operator ==(Object other) =>
      identical(this, other) || this.hashCode == other.hashCode;

  @override
  int get hashCode => id;

  @override
  List<Object> get props => [id, dureationRequired, details, labour, materials,
    totalCost, depositRequired, deliveryDate, traderId, jobId];

}