import '../../../core/configs/constants.dart';
import '../../domain/entities/message.dart';
import '../../domain/entities/message_box.dart';
import 'package:flutter/material.dart';
import '../blocs/message_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/auth.dart';
import '../../domain/repositories/message_repository.dart';
import 'message_input_field.dart';
import 'message_widget.dart';

class MessageBody extends StatefulWidget {
  MessageBody({
    Key key,
    @required this.messageBox,
    @required this.messages,
    this.showInputMessage = true,
  }) : super(key: key);

  final List<Message> messages;
  final bool showInputMessage;
  final MessageBox messageBox;

  @override
  _MessageBodyState createState() => _MessageBodyState();
}

class _MessageBodyState extends State<MessageBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: ListView.builder(
                itemCount: widget.messages.length,
                itemBuilder: (context, index) {
                  Message message = widget.messages[index];
                  final appType = AppConfig.of(context).appType;
                  if (message.entityStatus == EntityStatus.ENTIRY_STATUS_CREATING) {
                    Message copyMsg = Message(
                      jobId: message.jobId,
                      clientId: message.clientId,
                      traderId: message.traderId,
                      text: message.text,
                      subject: message.subject,
                      senderId: message.senderId,
                      recipientId: message.recipientId,
                      messageStatus: message.messageStatus,
                      entityStatus: message.entityStatus,
                      messageType: message.messageType,
                      isSender: message.isSender,
                    );
                    MessageBloc messageBloc = MessageBloc(
                      messageRepository: RepositoryProvider.of<MessageRepository>(
                          context),
                      appType: appType,
                      authLocalDataSource: sl<AuthLocalDataSource>(),
                    );
                        messageBloc.add(SendMessageEvent(message: message));
                    return BlocBuilder<MessageBloc, MessageState>(
                    bloc: messageBloc,
                         builder: (context, state) {
                          if (state is SendMessageFailed) {
                            //setState(() {
                              message.entityStatus = EntityStatus.ENTIRY_STATUS_ERROR;
                              message.messageStatus = MessageStatus.not_sent;
                            //});
                            //message.text = state.message.text;
                            return MessageWidget(message: message);
                          } else if (state is MessageSent) {
                            //setState(() {
                              message.entityStatus = EntityStatus.ENTIRY_STATUS_COMPLETED;
                              message.messageStatus = MessageStatus.not_view;
                              //message.text = state.message.text;
                            //});
                            return MessageWidget(message: message);
                          } else {
                            //setState(() {
                              //copyMsg.entityStatus = EntityStatus.ENTIRY_STATUS_CREATING;
                              copyMsg.text = '...';
                            //});
                            return MessageWidget(message: copyMsg);
                          }
                        },
                    );
                  } else {
                    return MessageWidget(message: message);
                  }
                }
              ),
            ),
          ),
          if (widget.showInputMessage == true)
            MessageInputField(
              // jobId: widget.messageBox.jobId,
              // clientId: widget.messageBox.clientId,
              // traderId: widget.messageBox.traderId,
              // subject: widget.messageBox.name,
              // senderId: widget.messageBox.senderId,
              // recepientId: widget.messageBox.recipientId,
              onMessageSend: (text) {
                Message message = Message(
                  jobId: widget.messageBox.jobId,
                  clientId: widget.messageBox.clientId,
                  traderId: widget.messageBox.traderId,
                  text: text,
                  subject: widget.messageBox.name,
                  senderId: widget.messageBox.senderId,
                  recipientId: widget.messageBox.recipientId,
                  messageStatus: MessageStatus.not_view,
                  entityStatus: EntityStatus.ENTIRY_STATUS_CREATING,
                  messageType: MessageType.text,
                  isSender: true
                );
                setState(() {
                  widget.messages.add(message);
                });
              },
            ),
        ],
      ),
    );
  }
}
