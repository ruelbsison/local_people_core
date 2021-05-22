import 'package:flutter/material.dart';

enum MessageType { text, audio, image, video }
enum MessageStatus { not_sent, not_view, viewed }

class Message {
  final int id;
  final int userId;
  final String text;
  final MessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;
  final String subject;
  final DateTime createdAt;

  Message({
    @required this.id,
    @required this.userId,
    @required this.subject,
    @required this.text,
    @required this.createdAt,
    @required this.messageType,
    @required this.messageStatus,
    @required this.isSender = false,
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
    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec finibus nulla vel iaculis aliquet. Integer lacus nibh, elementum id feugiat vel, hendrerit in metus. Donec interdum imperdiet sem eu facilisis. Duis eu sapien in elit eleifend dictum. Nunc at odio tempus lacus pretium fermentum.'?",
    messageType: MessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: true,
  ),
  Message(
    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec finibus nulla vel iaculis aliquet. Integer lacus nibh, elementum id feugiat vel, hendrerit in metus. Donec interdum imperdiet sem eu facilisis. Duis eu sapien in elit eleifend dictum. Nunc at odio tempus lacus pretium fermentum.'",
    messageType: MessageType.audio,
    messageStatus: MessageStatus.viewed,
    isSender: false,
  ),
  Message(
    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec finibus nulla vel iaculis aliquet. Integer lacus nibh, elementum id feugiat vel, hendrerit in metus. Donec interdum imperdiet sem eu facilisis. Duis eu sapien in elit eleifend dictum. Nunc at odio tempus lacus pretium fermentum.'",
    messageType: MessageType.video,
    messageStatus: MessageStatus.viewed,
    isSender: true,
  ),
  Message(
    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec finibus nulla vel iaculis aliquet. Integer lacus nibh, elementum id feugiat vel, hendrerit in metus. Donec interdum imperdiet sem eu facilisis. Duis eu sapien in elit eleifend dictum. Nunc at odio tempus lacus pretium fermentum.'",
    messageType: MessageType.text,
    messageStatus: MessageStatus.not_sent,
    isSender: true,
  ),
  Message(
    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec finibus nulla vel iaculis aliquet. Integer lacus nibh, elementum id feugiat vel, hendrerit in metus. Donec interdum imperdiet sem eu facilisis. Duis eu sapien in elit eleifend dictum. Nunc at odio tempus lacus pretium fermentum.'",
    messageType: MessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
  ),
  Message(
    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec finibus nulla vel iaculis aliquet. Integer lacus nibh, elementum id feugiat vel, hendrerit in metus. Donec interdum imperdiet sem eu facilisis. Duis eu sapien in elit eleifend dictum. Nunc at odio tempus lacus pretium fermentum.'",
    messageType: MessageType.text,
    messageStatus: MessageStatus.not_view,
    isSender: true,
  ),
];
