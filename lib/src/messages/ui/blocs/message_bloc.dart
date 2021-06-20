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
    if (event is LoadMessagesEvent) {
      yield MessageLoading();
      yield* _mapLoadMessagesToState();
    } else if (event is LoadJobMessagesEvent) {
      yield JobMessageLoading();
      yield* _mapLoadJobMessagesToState(event.jobId, event.traderId);
    } else if (event is SendMessageEvent) {
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

  Stream<MessageState> _mapLoadJobMessagesToState(int jobId, int traderId) async* {
    try {
      int userId = await authLocalDataSource.getUserId();
      MessageListResponse response = await messageRepository.listJobMessages(userId, jobId);
      if (response == null || response.exception != null) {
        yield LoadJobMessageFailed();
      } else if (response.messages != null) {
        if (traderId != null && traderId != -1) {
          List<Message> messages = [];
          var listIterator = response.messages.iterator;
          while(listIterator.moveNext() ) {
            Message msg = listIterator.current;
            if (msg.traderId == traderId) {
              messages.add(msg);
            }
          }
          yield JobMessageLoaded(messages: messages);
        } else {
          yield JobMessageLoaded(messages: response.messages);
        }
      }
    } catch (e) {
      yield LoadJobMessageFailed();
    }
  }

  Stream<MessageState> _mapSendMessagesToState(Message message) async* {
    try {
      // int userId = await authLocalDataSource.getUserId();
      // if (userId != null) {
      //   if (appType == AppType.CLIENT)
      //     message.clientId = userId;
      //   else
      //     message.traderId = userId;
      //   message.senderId = userId;
      //   message.isSender = true;
      // }

      if (message.subject == null || message.subject.length == 0) {
        message.subject = await authLocalDataSource.getUserName();
      }

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
