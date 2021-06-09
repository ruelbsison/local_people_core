import 'package:flutter/material.dart';

enum MessageType { text, audio, image, video }
enum MessageStatus { not_sent, not_view, viewed }

class Message implements Comparable {
  final int id;
  int clientId;
  final String text;
  final MessageType messageType;
  final MessageStatus messageStatus;
  bool isSender;
  String subject;
  final DateTime createdAt;
  final int jobId;
  int traderId;
  int senderId;

  Message({
    @required this.id,
    @required this.clientId,
    @required this.traderId,
    @required this.subject,
    @required this.text,
    @required this.createdAt,
    @required this.messageType,
    @required this.messageStatus,
    @required this.jobId,
    @required this.senderId,
    @required this.isSender,
  });

  @override
  int compareTo(other) {
    if (this.jobId < other.jobId) {
      return 1;
    }
    if (this.jobId > other.jobId) {
      return -1;
    }

    if (this.traderId < other.traderId) {
      return 1;
    }
    if (this.traderId > other.traderId) {
      return -1;
    }
    return 0;
  }
}

List<Message> demoMessages = [
  Message(
    subject: 'Sender Name',
    text: "Hi Sajol,",
    messageType: MessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
    clientId: 5,
    traderId: 2,
    createdAt: DateTime.now(),
    jobId: 1,
  ),
  Message(
    subject: 'Service Name',
    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec finibus nulla vel iaculis aliquet. Integer lacus nibh, elementum id feugiat vel, hendrerit in metus. Donec interdum imperdiet sem eu facilisis. Duis eu sapien in elit eleifend dictum. Nunc at odio tempus lacus pretium fermentum.'?",
    messageType: MessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: true,
    clientId: 5,
    traderId: 2,
    createdAt: DateTime.now(),
    jobId: 1,
  ),
  Message(
    subject: 'Sender Name',
    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec finibus nulla vel iaculis aliquet. Integer lacus nibh, elementum id feugiat vel, hendrerit in metus. Donec interdum imperdiet sem eu facilisis. Duis eu sapien in elit eleifend dictum. Nunc at odio tempus lacus pretium fermentum.'",
    messageType: MessageType.audio,
    messageStatus: MessageStatus.viewed,
    isSender: false,
    clientId: 5,
    traderId: 2,
    createdAt: DateTime.now(),
    jobId: 1,
  ),
  Message(
    subject: 'Service Name',
    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec finibus nulla vel iaculis aliquet. Integer lacus nibh, elementum id feugiat vel, hendrerit in metus. Donec interdum imperdiet sem eu facilisis. Duis eu sapien in elit eleifend dictum. Nunc at odio tempus lacus pretium fermentum.'",
    messageType: MessageType.video,
    messageStatus: MessageStatus.viewed,
    isSender: true,
    clientId: 5,
    traderId: 2,
    createdAt: DateTime.now(),
    jobId: 2,
  ),
  Message(
    subject: 'Sender Name',
    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec finibus nulla vel iaculis aliquet. Integer lacus nibh, elementum id feugiat vel, hendrerit in metus. Donec interdum imperdiet sem eu facilisis. Duis eu sapien in elit eleifend dictum. Nunc at odio tempus lacus pretium fermentum.'",
    messageType: MessageType.text,
    messageStatus: MessageStatus.not_sent,
    isSender: true,
    clientId: 5,
    traderId: 2,
    createdAt: DateTime.now(),
    jobId: 2,
  ),
  Message(
    subject: 'Service Name',
    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec finibus nulla vel iaculis aliquet. Integer lacus nibh, elementum id feugiat vel, hendrerit in metus. Donec interdum imperdiet sem eu facilisis. Duis eu sapien in elit eleifend dictum. Nunc at odio tempus lacus pretium fermentum.'",
    messageType: MessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
    clientId: 5,
    traderId: 2,
    createdAt: DateTime.now(),
    jobId: 2,
  ),
  Message(
    subject: 'Sender Name',
    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec finibus nulla vel iaculis aliquet. Integer lacus nibh, elementum id feugiat vel, hendrerit in metus. Donec interdum imperdiet sem eu facilisis. Duis eu sapien in elit eleifend dictum. Nunc at odio tempus lacus pretium fermentum.'",
    messageType: MessageType.text,
    messageStatus: MessageStatus.not_view,
    isSender: true,
    clientId: 5,
    traderId: 2,
    createdAt: DateTime.now(),
    jobId: 3,
  ),
];
