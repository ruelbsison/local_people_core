import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';
import '../../domain/entities/profile_item.dart';
import 'package:flutter_icons/flutter_icons.dart';

typedef void MoreProfileCallback();

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key key,
    @required this.profileItem,
    this.press,
  }) : super(key: key);

  final ProfileItem profileItem;
  final MoreProfileCallback press;

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
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: kDefaultPadding * 0.75),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage(profileItem.image),
                ),
                /*if (messageBox.isActive)
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
                  )*/
              ],
            ),
            Expanded(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      profileItem.name,
                      style:theme.textTheme.subtitle1,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    //SizedBox(height: 4),
                    Row (
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            profileItem.totalJobs.toString(),
                            style:theme.textTheme.bodyText1,
                            //textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(profileItem.totalAmountPaid.toString(),
                            style:theme.textTheme.bodyText1,
                            //textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    //SizedBox(height: 2),
                    Row (
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Jobs',
                            style:theme.textTheme.overline,
                            //textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Text(
                              'Total Paid',
                              style:theme.textTheme.overline,
                              //textAlign: TextAlign.center,
                            ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
             Opacity(
                opacity: 0.34,
                child: Icon(MaterialIcons.keyboard_arrow_right),
              ),
          ],
        ),
      ),
    );
  }
}
