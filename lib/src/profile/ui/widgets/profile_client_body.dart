import 'dart:async';
import 'package:flutter/material.dart';
import '../../domain/entities/client_profile.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:sliver_fab/sliver_fab.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:local_people_core/core.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileClientBody extends StatefulWidget {
  ProfileClientBody({@required this.profile});

  @override
  _ProfileClientBodyState createState() => _ProfileClientBodyState();

  final ClientProfile profile;
}

class _ProfileClientBodyState extends State<ProfileClientBody> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
        //textDirection: TextDirection.rtl,
        textAlign: TextAlign.left,
        style: theme.textTheme.bodyText2,
      ),
    );

    final aboutTheClient = Container(
      color: theme.backgroundColor,
      padding: EdgeInsets.all(12.0),
      //margin: EdgeInsets.all(12.0),
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'About ' + widget.profile.fullName != null
                ? widget.profile.fullName
                : '',
            textAlign: TextAlign.left,
            style: theme.textTheme.bodyText1,
          ),
          SizedBox(height: 10.0),
          Opacity(
            opacity: 0.64,
            child: Text(
              'Member since ' +
                  DateFormat('dd-MM-yyyy').format(widget.profile.memberSince),
              textAlign: TextAlign.left,
              style: theme.textTheme.bodyText2,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ClipOval(
                  child: SvgPicture.asset(
                    'packages/local_people_core/assets/images/verified.svg',
                    fit: BoxFit.contain,
                    height: 15,
                    width: 15,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Payment Method ' +
                        (widget.profile.paymentMethodVerified == true
                            ? 'Verified'
                            : 'Not Verified'),
                    textAlign: TextAlign.left,
                    style: theme.textTheme.bodyText1,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ClipOval(
                  child: SvgPicture.asset(
                    'packages/local_people_core/assets/images/verified.svg',
                    fit: BoxFit.contain,
                    height: 15,
                    width: 15,
                  ),
                ),
              ),
              Expanded(
                  flex: 5,
                  child: Flex(
                    direction: Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.profile.numOfJobsPosted.toString() +
                            ' Jobs Posted',
                        textAlign: TextAlign.left,
                        style: theme.textTheme.bodyText1,
                      ),
                      Opacity(
                        opacity: 0.84,
                        child: Text(
                          widget.profile.amountSpent.toString() +
                              ' Jobs commissioned',
                          textAlign: TextAlign.left,
                          style: theme.textTheme.bodyText2,
                        ),
                      )
                    ],
                  )),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ClipOval(
                  child: SvgPicture.asset(
                    'packages/local_people_core/assets/images/verified.svg',
                    fit: BoxFit.contain,
                    height: 15,
                    width: 15,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  widget.profile.amountSpent.toString() + ' Spent',
                  textAlign: TextAlign.left,
                  style: theme.textTheme.bodyText1,
                ),
              ),
            ],
          ),
        ],
      ),
    );

    final recentJobs = Container(
      color: theme.backgroundColor,
      padding: EdgeInsets.all(12.0),
      child: Text(
        'Recent Jobs',
        textAlign: TextAlign.left,
        style: theme.textTheme.bodyText1,
      ),
    );

    final recentJobItems = Container(
        color: Colors.white,
        padding: EdgeInsets.all(12.0),
        child: Container(
          height: 400,
        ));

    final reviewsGiven = Container(
      color: theme.backgroundColor,
      padding: EdgeInsets.all(12.0),
      child: Text(
        'Reviews Given',
        textAlign: TextAlign.left,
        style: theme.textTheme.bodyText1,
      ),
    );

    final reviewsGivenItems = Container(
      color: theme.backgroundColor,
      padding: EdgeInsets.all(12.0),
      child: SmoothStarRating(
          allowHalfRating: false,
          onRated: (v) {},
          starCount: 5,
          rating: 100,
          size: 32.0,
          isReadOnly: true,
          //fullRatedIconData: Icons.blur_off,
          //halfRatedIconData: Icons.blur_on,
          color: Color.fromRGBO(255, 99, 97, 1),
          borderColor: Color.fromRGBO(255, 99, 97, 1),
          spacing: 0.0),
    );

    final recommendations = Container(
      color: theme.backgroundColor,
      padding: EdgeInsets.all(12.0),
      child: Text(
        'Recommendations',
        textAlign: TextAlign.left,
        style: theme.textTheme.bodyText1,
      ),
    );

    final recommendationItems = Container(
        color: Colors.white,
        padding: EdgeInsets.all(12.0),
        child: Container(
          height: 300,
        ));

    // Widget bodyContent = SingleChildScrollView(
    //     physics: BouncingScrollPhysics(),
    //       child: Container(
    //         margin: EdgeInsets.all(12.0),
    //         //height: double.infinity,
    //         child: Flex (
    //           direction: Axis.vertical,
    //           //mainAxisSize: MainAxisSize.max,
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           crossAxisAlignment: CrossAxisAlignment.stretch,
    //           children: <Widget>[introductionActions, introduction, aboutTheClient],
    //         ),
    //       ),
    //   );
    //
    // return bodyContent;

    final List<Widget> columnChildren = <Widget>[
      introductionActions,
      introduction,
      aboutTheClient,
      recentJobs,
      recentJobItems,
      reviewsGiven,
      reviewsGivenItems,
      recommendations,
      recommendationItems
    ];

    Widget bodyContent = SliverList(
      delegate: new SliverChildListDelegate(
        columnChildren,
      ),
    );

    return bodyContent;
  }
}
