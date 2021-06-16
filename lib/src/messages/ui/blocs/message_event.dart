part of 'message_bloc.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();
}

class LoadMessagesEvent extends MessageEvent {
  @override
  List<Object> get props => [];
}

class LoadJobMessagesEvent extends MessageEvent {
  final int jobId;
  final int traderId;

  LoadJobMessagesEvent({@required this.jobId, @required this.traderId});

  @override
  List<Object> get props => [jobId, traderId];
}

class SendMessageEvent extends MessageEvent {
  Message message;

  SendMessageEvent({@required this.message});

  @override
  List<Object> get props => [message];
}
