import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
//import 'package:local_people_core/messages.dart';
import '../../domain/repositories/message_repository.dart';
import '../../../core/enum/app_type.dart';
import '../../domain/entities/message.dart';
import '../../domain/entities/message_box.dart';
import '../../domain/entities/message_response.dart';
import '../../domain/entities/message_list_response.dart';
import '../../data/models/message_model.dart';
import 'package:local_people_core/auth.dart';
import 'package:local_people_core/core.dart';

part 'message_box_event.dart';
part 'message_box_state.dart';

class MessageBoxBloc extends Bloc<MessageBoxEvent, MessageBoxState> {
  final MessageRepository messageRepository;
  final AppType appType;
  final AuthLocalDataSource authLocalDataSource;

  MessageBoxBloc({@required this.messageRepository,
    @required this.appType,
    @required this.authLocalDataSource}):
        super(MessageBoxInitial());

  @override
  Stream<MessageBoxState> mapEventToState(
    MessageBoxEvent event,
  ) async* {
    if (event is LoadMessageBoxEvent) {
      yield MessageBoxLoading();
      yield* _mapLoadMessageBoxToState();
    }
  }

  Stream<MessageBoxState> _mapLoadMessageBoxToState() async* {
    try {
      int userId = await authLocalDataSource.getUserId();
      MessageListResponse response;
      if (appType == AppType.CLIENT)
        response = await messageRepository.listClientMessages(userId);
      else
        response = await messageRepository.listTraderMessages(userId);
      if (response == null || response.exception != null) {
        yield LoadMessageBoxFailed();
      } else if (response.messages != null) {
        response.messages.sort((a, b) {
          return a.compareTo(b);
        });
        //String userFullName = await authLocalDataSource.getUserName();
        List<MessageBox> messages = List<MessageBox>();
        Message lastMessage;
        var listIterator = response.messages.iterator;
        while( listIterator.moveNext() ) {
          Message message = listIterator.current;
          // if (userFullName.toLowerCase().compareTo(userFullName.toLowerCase()) == 0)
          //   message.senderId = userId;
          // else
          //   message.senderId = message.clientId == userId ? message.traderId : message.clientId;
          if (lastMessage == null) {
            lastMessage = message;
          } else {
            if (message.jobId == lastMessage.jobId &&
                message.clientId == lastMessage.clientId &&
                message.traderId == lastMessage.traderId) {
              if (message.createdAt.isAfter(lastMessage.createdAt) == true) {
                lastMessage = message;
              }
            } else {
              MessageBox box = MessageBox(
                name: lastMessage.subject,
                jobId: lastMessage.jobId,
                traderId: lastMessage.traderId,
                lastMessage:lastMessage.text,
                image: "packages/local_people_core/assets/images/company-logo.png",
                time: DateFormatUtil.getDateTimeDiff(DateTime.now(), lastMessage.createdAt),
                isActive: false,
                createdAt: lastMessage.createdAt,
              );
              messages.add(box);
              lastMessage = message;
            }
          }
        }

        if (lastMessage != null) {
          MessageBox box = MessageBox(
            name: lastMessage.subject,
            jobId: lastMessage.jobId,
            traderId: lastMessage.traderId,
            lastMessage:lastMessage.text,
            image: "packages/local_people_core/assets/images/company-logo.png",
            time: DateFormatUtil.getDateTimeDiff(DateTime.now(), lastMessage.createdAt),
            isActive: false,
            createdAt: lastMessage.createdAt,
          );
          messages.add(box);
        }
        messages.sort((a, b) {
          return a.compareTo(b);
        });
        yield MessageBoxLoaded(messages: messages.reversed.toList());
      }
    } catch (e) {
      yield LoadMessageBoxFailed();
    }
  }
}
