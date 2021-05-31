import 'package:flutter/material.dart';

import '../../../core/configs//constants.dart';
import '../blocs/message_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/message.dart';

class MessageInputField extends StatefulWidget {
  MessageInputField({
    Key key,
    this.subject,
    this.jobId,
    this.clientId,
    this.traderId,
  }) : super(key: key);

  final String subject;
  final int jobId;
  final int clientId;
  final int traderId;

  @override
  _MessageInputFieldState createState() => _MessageInputFieldState();


}

class _MessageInputFieldState extends State<MessageInputField> {
  final TextEditingController _sendMessageTextController = TextEditingController();
  String msgText = '';
  FocusNode _focusNodeSendMessage = new FocusNode();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Icon(Icons.mic, color: theme.primaryColor),
            SizedBox(width: kDefaultPadding),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 0.75,
                ),
                decoration: BoxDecoration(
                  color: theme.primaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.sentiment_satisfied_alt_outlined,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .color
                          .withOpacity(0.64),
                    ),
                    SizedBox(width: kDefaultPadding / 4),
                    Expanded(
                      child: TextField(
                        focusNode: _focusNodeSendMessage,
                        controller: _sendMessageTextController,
                        decoration: InputDecoration(
                          hintText: "Type message",
                          border: InputBorder.none,
                        ),
                        //keyboardType: K,
                        textInputAction: msgText.length > 0 ? TextInputAction.go : TextInputAction.done,
                        onChanged: (msg) {
                          setState(() {
                            msgText = msg;
                          });
                        },
                        onSubmitted: (msg) {
                          setState(() {
                            if (msg.length > 0) {
                              _sendMessageTextController.clear();
                              _focusNodeSendMessage.requestFocus();
                              Message message = Message(
                                jobId: widget.jobId,
                                clientId: widget.clientId,
                                traderId: widget.traderId,
                                text: msg,
                                subject: widget.subject,
                              );
                              BlocProvider.of<MessageBloc>(context).add(SendMessageEvent(message: message));
                              //context.read<MessageBloc>().add(SendMessageEvent(message: message));
                            }
                          });
                        },
                      ),
                    ),
                    Icon(
                      Icons.attach_file,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .color
                          .withOpacity(0.64),
                    ),
                    SizedBox(width: kDefaultPadding / 4),
                    Icon(
                      Icons.camera_alt_outlined,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .color
                          .withOpacity(0.64),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
