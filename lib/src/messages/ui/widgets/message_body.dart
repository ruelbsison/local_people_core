import '../../../core/configs/constants.dart';
import '../../domain/entities/message.dart';
import '../../domain/entities/message_box.dart';
import 'package:flutter/material.dart';
import '../blocs/message_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/auth.dart';
import 'message_input_field.dart';
import 'message_widget.dart';

class MessageBody extends StatefulWidget {
  MessageBody({
    Key key,
    @required this.messageBox,
    @required this.messages,
    this.showInputMessage = true,
  }) : super(key: key);

  List<Message> messages;
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
                itemBuilder: (context, index) =>
                    MessageWidget(message: widget.messages[index]),
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
                  messageStatus: MessageStatus.not_sent,
                  entityStatus: EntityStatus.ENTIRY_STATUS_CREATING,
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
