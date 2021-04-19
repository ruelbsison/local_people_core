import 'package:local_people_core/core.dart';
//import '../../../core/configs/constants.dart';
import '../../domain/entities/message_box.dart';
import '../views/messages_screen.dart';
import 'package:flutter/material.dart';

import 'message_box_card.dart';

class MessageBoxBody extends StatelessWidget {
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
          child: ListView.builder(
            itemCount: messageBoxsData.length,
            itemBuilder: (context, index) => MessageBoxCard(
              messageBox: messageBoxsData[index],
              press: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MessagesScreen(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
