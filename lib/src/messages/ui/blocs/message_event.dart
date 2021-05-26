part of 'message_bloc.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();
}

class LoadMessageBoxEvent extends MessageEvent {
  @override
  List<Object> get props => [];
}

class LoadMessagesEvent extends MessageEvent {
  @override
  List<Object> get props => [];
}

class LoadJobMessagesEvent extends MessageEvent {
  final int jobId;

  LoadJobMessagesEvent({@required this.jobId});

  @override
  List<Object> get props => [jobId];
}

class SendMessageEvent extends MessageEvent {
  final Message message;

  SendMessageEvent({@required this.message});

  @override
  List<Object> get props => [message];
}
