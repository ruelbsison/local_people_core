import 'package:local_people_core/messages.dart';

List<Message> testMessages = [
  Message(
    subject: 'Sender Name',
    text: "Hi Sajol,",
    messageType: MessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
    clientId: 1,
    traderId: 1,
    createdAt: DateTime.now(),
    jobId: 1,
  ),
  Message(
    subject: 'Service Name',
    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec finibus nulla vel iaculis aliquet. Integer lacus nibh, elementum id feugiat vel, hendrerit in metus. Donec interdum imperdiet sem eu facilisis. Duis eu sapien in elit eleifend dictum. Nunc at odio tempus lacus pretium fermentum.'?",
    messageType: MessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: true,
    clientId: 2,
    traderId: 1,
    createdAt: DateTime.now(),
    jobId: 2,
  ),
  Message(
    subject: 'Sender Name',
    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec finibus nulla vel iaculis aliquet. Integer lacus nibh, elementum id feugiat vel, hendrerit in metus. Donec interdum imperdiet sem eu facilisis. Duis eu sapien in elit eleifend dictum. Nunc at odio tempus lacus pretium fermentum.'",
    messageType: MessageType.audio,
    messageStatus: MessageStatus.viewed,
    isSender: false,
    clientId: 1,
    traderId: 2,
    createdAt: DateTime.now(),
    jobId: 3,
  ),
  Message(
    subject: 'Service Name',
    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec finibus nulla vel iaculis aliquet. Integer lacus nibh, elementum id feugiat vel, hendrerit in metus. Donec interdum imperdiet sem eu facilisis. Duis eu sapien in elit eleifend dictum. Nunc at odio tempus lacus pretium fermentum.'",
    messageType: MessageType.video,
    messageStatus: MessageStatus.viewed,
    isSender: true,
    clientId: 2,
    traderId: 2,
    createdAt: DateTime.now(),
    jobId: 4,
  ),
  Message(
    subject: 'Sender Name',
    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec finibus nulla vel iaculis aliquet. Integer lacus nibh, elementum id feugiat vel, hendrerit in metus. Donec interdum imperdiet sem eu facilisis. Duis eu sapien in elit eleifend dictum. Nunc at odio tempus lacus pretium fermentum.'",
    messageType: MessageType.text,
    messageStatus: MessageStatus.not_sent,
    isSender: true,
    clientId: 1,
    traderId: 1,
    createdAt: DateTime.now(),
    jobId: 1,
  ),
  Message(
    subject: 'Service Name',
    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec finibus nulla vel iaculis aliquet. Integer lacus nibh, elementum id feugiat vel, hendrerit in metus. Donec interdum imperdiet sem eu facilisis. Duis eu sapien in elit eleifend dictum. Nunc at odio tempus lacus pretium fermentum.'",
    messageType: MessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
    clientId: 2,
    traderId: 1,
    createdAt: DateTime.now(),
    jobId: 2,
  ),
  Message(
    subject: 'Sender Name',
    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec finibus nulla vel iaculis aliquet. Integer lacus nibh, elementum id feugiat vel, hendrerit in metus. Donec interdum imperdiet sem eu facilisis. Duis eu sapien in elit eleifend dictum. Nunc at odio tempus lacus pretium fermentum.'",
    messageType: MessageType.text,
    messageStatus: MessageStatus.not_view,
    isSender: true,
    clientId: 1,
    traderId: 1,
    createdAt: DateTime.now(),
    jobId: 3,
  ),
];