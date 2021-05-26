part of 'message_bloc.dart';

abstract class MessageState extends Equatable {
  const MessageState();
}

class MessageInitial extends MessageState {
  @override
  List<Object> get props => [];
}

class MessageSending extends MessageState {
  @override
  List<Object> get props => [];
}

class SendMessageFailed extends MessageState {
  @override
  List<Object> get props => [];
}

class MessageSent extends MessageState {
  final Message message;

  MessageSent({@required this.message});

  @override
  List<Object> get props => [message];
}

class MessageLoading extends MessageState {
  @override
  List<Object> get props => [];
}

class LoadMessageFailed extends MessageState {
  @override
  List<Object> get props => [];
}

class MessageLoaded extends MessageState {
  final List<Message> messages;

  MessageLoaded({@required this.messages});

  @override
  List<Object> get props => [messages];
}

class JobMessageLoading extends MessageState {
  @override
  List<Object> get props => [];
}

class LoadJobMessageFailed extends MessageState {
  @override
  List<Object> get props => [];
}

class JobMessageLoaded extends MessageState {
  final List<Message> messages;

  JobMessageLoaded({@required this.messages});

  @override
  List<Object> get props => [messages];
}

class MessageBoxLoading extends MessageState {
  @override
  List<Object> get props => [];
}

class LoadMessageBoxFailed extends MessageState {
  @override
  List<Object> get props => [];
}

class MessageBoxLoaded extends MessageState {
  final List<MessageBox> messages;

  MessageBoxLoaded({@required this.messages});

  @override
  List<Object> get props => [messages];
}
