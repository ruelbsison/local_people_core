import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tag_model.g.dart';

/// {@template TagModel}
/// TagModel model
///
/// [TagModel.empty] represents an unauthenticated TagModel.
/// {@endtemplate}
@JsonSerializable()
class TagModel extends Equatable {
  /// {@macro TagModel}
  TagModel({
    @required this.id,
    @required this.name,
    this.created_at,
    this.updated_at,
  })  : assert(id != null);

  /// The current TagModel's email address.
  String name;

  /// The current TagModel's id.
  int id;

  String created_at;

  String updated_at;

  /// Empty TagModel which represents an unauthenticated TagModel.
  //static empty = TagModel(id: -1, title: '', description: '', date: '', budget: '', awarded: false, created_at: '', updated_at: '', client_id: 0, trader_id: 0);

  @override
  List<Object> get props => [id, name, created_at, updated_at];

  factory TagModel.fromJson(Map<String, dynamic> json) => _$TagModelFromJson(json);
  Map<String, dynamic> toJson() => _$TagModelToJson(this);
}
