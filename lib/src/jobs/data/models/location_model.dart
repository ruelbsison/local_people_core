import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location_model.g.dart';

/// {@template LocationModel}
/// LocationModel model
///
/// [LocationModel.empty] represents an unauthenticated LocationModel.
/// {@endtemplate}
@JsonSerializable()
class LocationModel extends Equatable {
  /// {@macro LocationModel}
  LocationModel({
    @required this.id,
    @required this.name,
    @required this.address,
    this.created_at,
    this.updated_at,
    this.client_id,
    this.trader_id,
    this.latitude,
    this.longitude,
    this.job_id,
  })  : assert(id != null);

  /// The current LocationModel's email address.
  String name;

  /// The current LocationModel's id.
  int id;

  /// The current LocationModel's name (display name).
  String address;

  String created_at;

  String updated_at;

  int latitude;

  int longitude;

  int client_id;

  int trader_id;

  int job_id;

  /// Empty LocationModel which represents an unauthenticated LocationModel.
  //static empty = LocationModel(id: -1, title: '', description: '', date: '', budget: '', awarded: false, created_at: '', updated_at: '', client_id: 0, trader_id: 0);

  @override
  List<Object> get props => [id, name, address, created_at, updated_at, client_id, trader_id, latitude, longitude, job_id];

  factory LocationModel.fromJson(Map<String, dynamic> json) => _$LocationModelFromJson(json);
  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}
