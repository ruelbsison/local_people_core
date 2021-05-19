import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

/// {@template MessageModel}
/// MessageModel model
///
/// [MessageModel.empty] represents an unauthenticated MessageModel.
/// {@endtemplate}
@JsonSerializable()
class MessageModel extends Equatable {
  /// {@macro MessageModel}
  MessageModel({
    @required this.id,
    @required this.subject,
    @required this.body,
    this.read,
    this.client_id,
    this.trader_idt,
    this.created_at,
    this.updated_at,
  })  : assert(id != null);

  int id;
  /// The current MessageModel's email address.
  String subject;

  /// The current MessageModel's id.
  int client_id;

  int trader_idt;

  String body;

  bool read;

  String created_at;

  String updated_at;

  int job_id;

  /// Empty MessageModel which represents an unauthenticated MessageModel.
  //static empty = MessageModel(id: -1, title: '', description: '', date: '', budget: '', awarded: false, created_at: '', updated_at: '', client_id: 0, trader_id: 0);

  @override
  List<Object> get props => [id, subject, body, client_id, trader_idt, read, created_at, updated_at, job_id];

  factory MessageModel.fromJson(Map<String, dynamic> json) => _$MessageModelFromJson(json);
  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
