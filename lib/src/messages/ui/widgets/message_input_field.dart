import 'package:flutter/material.dart';

import '../../../core/configs//constants.dart';
import '../blocs/message_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/message.dart';
import 'package:flutter_svg/flutter_svg.dart';

typedef OnMessageSend = void Function(String);

class MessageInputField extends StatefulWidget {
  MessageInputField({
    Key key,
    this.onMessageSend,
    // this.subject,
    // this.jobId,
    // this.clientId,
    // this.traderId,
    // this.senderId,
    // this.recepientId,
  }) : super(key: key);

  final OnMessageSend onMessageSend;
  // final String subject;
  // final int jobId;
  // final int clientId;
  // final int traderId;
  // final int senderId;
  // final int recepientId;

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
        horizontal: kDefaultPadding / 3,
        vertical: kDefaultPadding / 3,
      ),
      decoration: BoxDecoration(
        color: theme.primaryColor, //Theme.of(context).scaffoldBackgroundColor,
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
            //Icon(Icons.mic, color: theme.primaryColor),
            IconButton(
              icon: SvgPicture.asset(
                'packages/local_people_core/assets/images/camera.svg',
                fit: BoxFit.contain,
                height: 30,
                width: 30,
              ),
              iconSize: 30,
              onPressed: () {
                // TODO Ruel
              },
            ),
            SizedBox(width: kDefaultPadding),
            Expanded(
              child: Container(
                // padding: EdgeInsets.symmetric(
                //   horizontal: kDefaultPadding * 0.75,
                // ),
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    // Icon(
                    //   Icons.sentiment_satisfied_alt_outlined,
                    //   color: Theme.of(context)
                    //       .textTheme
                    //       .bodyText1
                    //       .color
                    //       .withOpacity(0.64),
                    // ),
                    //SizedBox(width: kDefaultPadding / 4),
                    Expanded(
                      child: TextField(
                        autofocus: true,
                        focusNode: _focusNodeSendMessage,
                        controller: _sendMessageTextController,
                        decoration: InputDecoration(
                          hintText: "Type message",
                          border: InputBorder.none,
                        ),
                        //keyboardType: K,
                        textCapitalization: TextCapitalization.sentences,
                        textInputAction: msgText.length > 0 ? TextInputAction.go : TextInputAction.done,
                        onChanged: (msg) {
                          setState(() {
                            msgText = msg;
                          });
                        },
                        onSubmitted: (msg) {
                          setState(() {
                            if (msg.length > 0) {
                              _focusNodeSendMessage.requestFocus();
                              if (widget.onMessageSend != null)
                                widget.onMessageSend(msg);
                              _sendMessageTextController.clear();
                            }
                          });
                        },
                      ),
                    ),
                    IconButton(
                      icon: SvgPicture.asset(
                        'packages/local_people_core/assets/images/send.svg',
                        fit: BoxFit.contain,
                        height: 30,
                        width: 30,
                      ),
                      iconSize: 30,
                      onPressed: () {
                        setState(() {
                          if (_sendMessageTextController.text.length > 0) {
                            _focusNodeSendMessage.requestFocus();
                            if (widget.onMessageSend != null)
                              widget..onMessageSend(_sendMessageTextController.text);
                            _sendMessageTextController.clear();
                          }
                        });
                      },
                    ),
                    // Icon(
                    //   Icons.attach_file,
                    //   color: Theme.of(context)
                    //       .textTheme
                    //       .bodyText1
                    //       .color
                    //       .withOpacity(0.64),
                    // ),
                    // SizedBox(width: kDefaultPadding / 4),
                    // Icon(
                    //   Icons.camera_alt_outlined,
                    //   color: Theme.of(context)
                    //       .textTheme
                    //       .bodyText1
                    //       .color
                    //       .withOpacity(0.64),
                    // ),
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
