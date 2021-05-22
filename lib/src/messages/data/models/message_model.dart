import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/message.dart';
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
    this.trader_id,
    this.created_at,
    this.updated_at,
  })  : assert(id != null);

  int id;
  /// The current MessageModel's email address.
  String subject;

  /// The current MessageModel's id.
  int client_id;

  int trader_id;

  String body;

  bool read;

  String created_at;

  String updated_at;

  int job_id;

  static MessageModel fromMessage(Message message) {
    return MessageModel (
    id: message.id,
    subject: message.subject,
    body: message.text.toString(),
    read: false,
    client_id: message.userId,
    trader_id: message.userId,
    created_at: DateFormat("yyyy-MM-dd'T'HH:mm:ss.ms'Z'").format(message.createdAt),
    );
  }

  /// Empty MessageModel which represents an unauthenticated MessageModel.
  //static empty = MessageModel(id: -1, title: '', description: '', date: '', budget: '', awarded: false, created_at: '', updated_at: '', client_id: 0, trader_id: 0);

  @override
  List<Object> get props => [id, subject, body, client_id, trader_id, read, created_at, updated_at, job_id];

  factory MessageModel.fromJson(Map<String, dynamic> json) => _$MessageModelFromJson(json);
  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
