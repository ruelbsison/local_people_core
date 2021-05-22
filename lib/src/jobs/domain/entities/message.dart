import 'dart:ui';
import 'dart:io';
import 'package:meta/meta.dart';

class Message extends Object {
  Message({
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

  @override
  List<Object> get props => [id, subject, body, client_id, trader_idt, read, created_at, updated_at, job_id];
}
