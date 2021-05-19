import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:local_people_core/core.dart';
import '../../domain/entities/more_item.dart';

typedef void MoreItemCallback();

class MoreItemCard extends StatelessWidget {
  const MoreItemCard({
    Key key,
    @required this.item,
    @required this.press,
  }) : super(key: key);

  final MoreItem item;
  final MoreItemCallback press;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: press,
      child:  Container(
        //padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.circular(5.0),
        ),
        //color: Colors.white,
        //padding: EdgeInsets.all(kDefaultPadding),
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: kDefaultPadding * 0.75),
        child: Stack(
          children: [
            Row (
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Icon (item.icon),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child:  Text(
                      item.name,
                      style: theme.textTheme.subtitle1
                  ),
                ),
                Expanded(
                  flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(left: 14.0),
                      child: Opacity(
                      opacity: 0.34,
                      child: Icon(MaterialIcons.keyboard_arrow_right),
                    ),),
                ),
              ],
            ),
            if (item.isActive)
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
      ),
    );
  }
}
