import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:local_people_core/messages.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../../domain/repositories/message_repository.dart';
import '../../../core/enum/app_type.dart';
import '../../domain/entities/message.dart';
import 'package:local_people_core/auth.dart';
import 'package:local_people_core/core.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepository messageRepository;
  final AppType appType;
  final AuthLocalDataSource authLocalDataSource;

  MessageBloc({@required this.messageRepository,
    @required this.appType,
    @required this.authLocalDataSource}):
        super(MessageInitial());

  @override
  Stream<MessageState> mapEventToState(
    MessageEvent event,
  ) async* {
    if (event is LoadMessages) {
      yield MessageLoading();
      yield* _mapLoadMessagesToState();
    } else if (event is LoadJobMessages) {
      yield JobMessageLoading();
      yield* _mapLoadJobMessagesToState(event.jobId);
    } else if (event is SendMessage) {
      yield MessageSending();
      yield* _mapSendMessagesToState(event.message);
    }
  }

  Stream<MessageState> _mapLoadMessagesToState() async* {
    try {
      int userId = await authLocalDataSource.getUserId();
      MessageListResponse response;
      if (appType == AppType.CLIENT)
        response = await messageRepository.listClientMessages(userId);
      else
        response = await messageRepository.listTraderMessages(userId);
      if (response == null || response.exception != null) {
        yield LoadMessageFailed();
      } else if (response.messages != null) {
        yield MessageLoaded(messages: response.messages);
      }
    } catch (e) {
      yield LoadMessageFailed();
    }
  }

  Stream<MessageState> _mapLoadJobMessagesToState(int jobId) async* {
    try {
      MessageListResponse response = await messageRepository.listJobMessages(jobId);
      if (response == null || response.exception != null) {
        yield LoadJobMessageFailed();
      } else if (response.messages != null) {
        yield JobMessageLoaded(messages: response.messages);
      }
    } catch (e) {
      yield LoadJobMessageFailed();
    }
  }

  Stream<MessageState> _mapSendMessagesToState(Message message) async* {
    try {
      MessageResponse response = await messageRepository.createMessage(message);
      if (response == null || response.exception != null) {
        yield SendMessageFailed();
      } else if (response.message != null) {
        yield MessageSent(message: response.message);
      }
    } catch (e) {
      yield SendMessageFailed();
    }
  }
}
