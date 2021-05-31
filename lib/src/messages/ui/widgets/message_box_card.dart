import '../../domain/entities/message_box.dart';
import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';

class MessageBoxCard extends StatelessWidget {
  const MessageBoxCard({
    Key key,
    @required this.messageBox,
    @required this.press,
  }) : super(key: key);

  final MessageBox messageBox;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: press,
      child: Container (
        padding: EdgeInsets.only(top: 6.0, bottom: 6.0),
        margin: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.circular(5.0),
        ),
        //padding: EdgeInsets.all(kDefaultPadding),
        // padding: const EdgeInsets.symmetric(
        //     horizontal: kDefaultPadding, vertical: kDefaultPadding * 0.75),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage(messageBox.image),
                ),
                if (messageBox.isActive)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 16,
                      width: 16,
                      decoration: BoxDecoration(
                        color: theme.primaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            width: 3),
                      ),
                    ),
                  )
              ],
            ),
            Expanded(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      messageBox.name,
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 8),
                    Opacity(
                      opacity: 0.64,
                      child: Text(
                        messageBox.lastMessage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Opacity(
              opacity: 0.64,
              child: Text(
                DateFormatUtil.getDateTimeDiff(DateTime.now(), messageBox.createdAt),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
