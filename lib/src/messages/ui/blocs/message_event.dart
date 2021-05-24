part of 'message_bloc.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();
}

class LoadMessages extends MessageEvent {
  @override
  List<Object> get props => [];
}

class LoadJobMessages extends MessageEvent {
  final int jobId;

  LoadJobMessages({@required this.jobId});

  @override
  List<Object> get props => [jobId];
}

class SendMessage extends MessageEvent {
  final Message message;

  SendMessage({@required this.message});

  @override
  List<Object> get props => [message];
}
