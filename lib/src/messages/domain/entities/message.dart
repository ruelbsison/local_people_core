import 'package:flutter/material.dart';

enum MessageType { text, audio, image, video }
enum MessageStatus { not_sent, not_view, viewed }

class Message {
  final String text;
  final MessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;

  Message({
    this.text,
    @required this.messageType,
    @required this.messageStatus,
    @required this.isSender,
  });
}

List demeMessages = [
  Message(
    text: "Hi Sajol,",
    messageType: MessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
  ),
  Message(
    text: "Hello, How are you?",
    messageType: MessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: true,
  ),
  Message(
    text: "",
    messageType: MessageType.audio,
    messageStatus: MessageStatus.viewed,
    isSender: false,
  ),
  Message(
    text: "",
    messageType: MessageType.video,
    messageStatus: MessageStatus.viewed,
    isSender: true,
  ),
  Message(
    text: "Error happend",
    messageType: MessageType.text,
    messageStatus: MessageStatus.not_sent,
    isSender: true,
  ),
  Message(
    text: "This looks great man!!",
    messageType: MessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
  ),
  Message(
    text: "Glad you like it",
    messageType: MessageType.text,
    messageStatus: MessageStatus.not_view,
    isSender: true,
  ),
];
