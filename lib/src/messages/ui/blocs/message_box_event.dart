part of 'message_box_bloc.dart';

abstract class MessageBoxEvent extends Equatable {
  const MessageBoxEvent();
}

class LoadMessageBoxEvent extends MessageBoxEvent {
  @override
  List<Object> get props => [];
}
