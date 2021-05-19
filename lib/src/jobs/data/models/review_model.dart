import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'review_model.g.dart';

/// {@template ReviewModel}
/// ReviewModel model
///
/// [ReviewModel.empty] represents an unauthenticated ReviewModel.
/// {@endtemplate}
@JsonSerializable()
class ReviewModel extends Equatable {
  /// {@macro ReviewModel}
  ReviewModel({
    @required this.id,
    @required this.title,
    @required this.description,
    this.rating,
    this.job_id,
    this.client_id,
    this.trader_idt,
    this.created_at,
    this.updated_at,
  })  : assert(id != null);

  int id;
  /// The current ReviewModel's email address.
  String title;

  String description;

  int rating;

  int job_id;

  /// The current ReviewModel's id.
  int client_id;

  int trader_idt;

  String created_at;

  String updated_at;

  /// Empty ReviewModel which represents an unauthenticated ReviewModel.
  //static empty = ReviewModel(id: -1, title: '', description: '', date: '', budget: '', awarded: false, created_at: '', updated_at: '', client_id: 0, trader_id: 0);

  @override
  List<Object> get props => [id, title, description, client_id, trader_idt, created_at, updated_at, job_id];

  factory ReviewModel.fromJson(Map<String, dynamic> json) => _$ReviewModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}
