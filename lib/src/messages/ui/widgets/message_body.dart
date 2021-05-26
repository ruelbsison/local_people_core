import '../../../core/configs/constants.dart';
import '../../domain/entities/message.dart';
import 'package:flutter/material.dart';
import '../blocs/message_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'message_input_field.dart';
import 'message_widget.dart';

class MessageBody extends StatelessWidget {
  const MessageBody({
    Key key,
    @required this.messages,
  }) : super(key: key);

  final List<Message> messages;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) =>
                  MessageWidget(message: messages[index]),
            ),
        ),
        ),
        MessageInputField(),
      ],
    );
  }
}
