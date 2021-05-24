import '../../../core/configs/constants.dart';
import '../../domain/entities/message.dart';
import 'package:flutter/material.dart';

import 'message_input_field.dart';
import 'message_widget.dart';

class MessageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: ListView.builder(
              itemCount: demoMessages.length,
              itemBuilder: (context, index) =>
                  MessageWidget(message: demoMessages[index]),
            ),
          ),
        ),
        MessageInputField(),
      ],
    );
  }
}
