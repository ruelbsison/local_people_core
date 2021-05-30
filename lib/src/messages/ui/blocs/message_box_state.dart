part of 'message_box_bloc.dart';

abstract class MessageBoxState extends Equatable {
  const MessageBoxState();
}

class MessageBoxInitial extends MessageBoxState {
  @override
  List<Object> get props => [];
}

class MessageBoxLoading extends MessageBoxState {
  @override
  List<Object> get props => [];
}

class LoadMessageBoxFailed extends MessageBoxState {
  @override
  List<Object> get props => [];
}

class MessageBoxLoaded extends MessageBoxState {
  final List<MessageBox> messages;

  MessageBoxLoaded({@required this.messages});

  @override
  List<Object> get props => [messages];
}
