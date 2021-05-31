import 'package:local_people_core/core.dart';
//import '../../../core/configs/constants.dart';
import '../../domain/entities/message_box.dart';
import '../views/messages_screen.dart';
import 'package:flutter/material.dart';
import '../blocs/message_box_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'message_box_card.dart';

class MessageBoxBody extends StatelessWidget {
  const MessageBoxBody({
    Key key,
    @required this.messages,
  }) : super(key: key);

  final List<MessageBox> messages;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        /*Container(
          padding: EdgeInsets.fromLTRB(
              kDefaultPadding, 0, kDefaultPadding, kDefaultPadding),
          color: theme.primaryColor,
          child: Row(
            children: [
              FillOutlineButton(press: () {}, text: "Recent Message"),
              SizedBox(width: kDefaultPadding),
              FillOutlineButton(
                press: () {},
                text: "Active",
                isFilled: false,
              ),
            ],
          ),
        ),*/
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async{
              context.read<MessageBoxBloc>().add(LoadMessageBoxEvent());
            },
            child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) => MessageBoxCard(
              messageBox: messages[index],
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MessagesScreen(messageBox: messages[index],),
                  ),
                );
                context.read<MessageBoxBloc>().add(LoadMessageBoxEvent());
              }
            ),
          ),
        ),
      )
    ],
    );
  }
}
