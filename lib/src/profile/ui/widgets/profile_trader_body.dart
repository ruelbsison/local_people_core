import 'package:flutter/material.dart';
import '../../domain/entities/trader_profile.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:local_people_core/core.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package_widget.dart';
import '../../domain/entities/package.dart';
import 'package_card.dart';
import 'qualification_card.dart';
import 'qualification_widget.dart';

class ProfileTraderBody extends StatefulWidget {
  ProfileTraderBody({@required this.profile});

  @override
  _ProfileTraderBodyState createState() => _ProfileTraderBodyState();

  final TraderProfile profile;
}

class _ProfileTraderBodyState extends State<ProfileTraderBody> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    final introductionActions = Container(
      color: theme.backgroundColor,
      padding: EdgeInsets.all(12.0),
      //margin: EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Text(
              'Introduction',
              textAlign: TextAlign.left,
              style: theme.textTheme.bodyText1,
            ),
          ),
          Expanded(
            flex: 1,
            child: Icon(
              MaterialIcons.edit,
            ),
          ),
          Expanded(
            flex: 1,
            child: Icon(
              MaterialIcons.clear_all,
            ),
          ),
        ],
      ),
    );

    final introduction = Container(
      color: theme.backgroundColor,
      padding: EdgeInsets.all(12.0),
      //margin: EdgeInsets.all(12.0),
      child: Text(
        widget.profile.intro != null ? widget.profile.intro : '',
        maxLines: 12,
        overflow: TextOverflow.ellipsis,
        //textDirection: TextDirection.RTL,
        textAlign: TextAlign.left,
        style: theme.textTheme.bodyText2,
      ),
    );

    final qualificationsContent = Container(
      color: theme.backgroundColor,
      padding: EdgeInsets.all(12.0),
      //margin: EdgeInsets.all(12.0),
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 10),
              //padding: EdgeInsets.only(left: 12, top: 40),
              child: Text(
                'Qualifications',
                textAlign: TextAlign.left,
                style: theme.textTheme.bodyText1,
              ),
            ),
          ),
          // Expanded(
          //   child: Container(
          //       padding: EdgeInsets.only(left: 10),
          //       child: PackageWidget(
          //         packages: [Package(name: 'Package 01')],
          //       )
          //   ),
          // ),
        ],
      ),
    );

    final List<Widget> columnChildren = <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: (size.width - 10) / 2,
                //height: 36,
                padding: EdgeInsets.all(16.0),
                //padding: EdgeInsets.only(left: 12, top: 40),
                child: ElevatedButton(
                  onPressed: () => {},
                  child: Text(
                    'Message',
                    //LocalPeopleLocalizations.of(context)
                    //    .btnTitleCancel,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.button,
                  ),
                ),
                //color: Colors.green,
              ),
            ),
          ),
          Expanded(
            child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: (size.width - 10) / 2,
                  //height: 36,
                  padding: EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () => {},
                    child: Text(
                      'Request Quote',
                      //LocalPeopleLocalizations.of(context)
                      //    .btnTitleCancel,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.button,
                    ),
                  ),
                )),
          ),
        ],
      ),
      introductionActions,
      introduction,
      QualificationWidget (
        qualifications: ['Handy Man', 'Window Cleaner', 'Qualification 01',],
      ),
      SizedBox(height: 20),
      PackageWidget(
        packages: [
          Package(
            name: 'Package 01',
            description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec finibus nulla vel iaculis aliquet. Integer lacus nibh, elementum id feugiat vel, hendrerit in metus.',
            durationInHours: 2,
            cost: 150.0,
        ),
          Package(
              name: 'Package 02',
          ),
        ],
      ),
      SizedBox(height: 40),
    ];

    Widget bodyContent = SliverList(
      delegate: new SliverChildListDelegate(
        columnChildren,
      ),
    );

    return bodyContent;
  }
}
