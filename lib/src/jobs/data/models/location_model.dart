import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/location.dart';

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
    this.id,
    @required this.name,
    @required this.address,
    @required this.client_id,
    @required this.trader_id,
    this.job_id,
    this.created_at,
    this.updated_at,
  }) : assert(name != null), assert(address != null);

  /// The current LocationModel's email address.
  String name;

  /// The current LocationModel's id.
  int id;

  /// The current LocationModel's name (display name).
  String address;

  String created_at;

  String updated_at;

  double latitude;

  double longitude;

  int client_id;

  int trader_id;

  int job_id;

  /// Empty LocationModel which represents an unauthenticated LocationModel.
  static empty() {
    return LocationModel(
        id: -1,
        name: '',
        address: '',
        // latitude: 9,
        // longitude: 0,
        created_at: '',
        updated_at: '',
        client_id: 0,
        trader_id: 0,
      job_id: 0,
    );
  }

  static LocationModel fromLocation(Location location) {
    return LocationModel(
      id: location.id,
      name: location.name,
      address: location.address,
      // latitude: location.lat.toInt(),
      // longitude: location.long.toInt(),
      job_id: location.jobId,
      client_id: location.clientId,
      trader_id: location.traderId,
    );
  }

  @override
  List<Object> get props => [id, name, address, created_at, updated_at, client_id, trader_id, job_id];

  factory LocationModel.fromJson(Map<String, dynamic> json) => _$LocationModelFromJson(json);
  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}
