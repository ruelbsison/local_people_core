import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'location_model.dart';
import 'tag_model.dart';
part 'job_model.g.dart';

/// {@template JobModel}
/// JobModel model
///
/// [JobModel.empty] represents an unauthenticated JobModel.
/// {@endtemplate}
@JsonSerializable()
class JobModel extends Equatable {
  /// {@macro JobModel}
  JobModel({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.date,
    @required this.budget,
    @required this.awarded,
    this.created_at,
    this.updated_at,
    this.client_id,
    this.trader_id,
    this.location,
    this.tags,
  })  : assert(id != null);

  /// The current JobModel's email address.
  String title;

  /// The current JobModel's id.
  int id;

  /// The current JobModel's name (display name).
  String description;

  /// The current JobModel's name (display name).
  String date;

  String budget;

  bool awarded;

  String created_at;

  String updated_at;

  int client_id;

  int trader_id;

  LocationModel location;

  List<TagModel> tags;

  /// Empty JobModel which represents an unauthenticated JobModel.
  static empty() {
    new JobModel(id: -1,
        title: '',
        description: '',
        date: '',
        budget: '',
        awarded: false,
        created_at: '',
        updated_at: '',
        client_id: 0,
        trader_id: 0,
      tags: [TagModel.empty()],
      location: LocationModel.empty(),
    );
  }

  @override
  List<Object> get props => [id, title, description, date, budget, created_at, updated_at, client_id, trader_id, location, tags];

  factory JobModel.fromJson(Map<String, dynamic> json) => _$JobModelFromJson(json);
  Map<String, dynamic> toJson() => _$JobModelToJson(this);
}
