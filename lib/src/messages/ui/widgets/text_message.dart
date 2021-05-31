import '../../domain/entities/message.dart';
import 'package:flutter/material.dart';

import '../../../core/configs/constants.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key key,
    this.message,
  }) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
              padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
              margin: EdgeInsets.all(12.0),
              // padding: EdgeInsets.symmetric(
              //   horizontal: kDefaultPadding * 0.75,
              //   vertical: kDefaultPadding / 2,
              // ),
              // decoration: BoxDecoration(
              //   color: theme
              //       .primaryColor, //.primaryColor.withOpacity(message.isSender ? 1 : 0.1),
              //   borderRadius: BorderRadius.circular(30),
              // ),
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  message.text,
                  maxLines: 250,
                  style: TextStyle(
                    color: message.isSender
                        ? Colors.white
                        : Theme.of(context).textTheme.bodyText1.color,
                  ),
                ),
              ),
            );
  }
}
