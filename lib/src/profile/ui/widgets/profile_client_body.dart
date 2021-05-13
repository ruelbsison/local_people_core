import 'dart:async';
import 'package:flutter/material.dart';
import '../../domain/entities/client_profile.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:sliver_fab/sliver_fab.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

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
        children: <Widget> [
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
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec finibus nulla vel iaculis aliquet. Integer lacus nibh, elementum id feugiat vel, hendrerit in metus. Donec interdum imperdiet sem eu facilisis. Duis eu sapien in elit eleifend dictum. Nunc at odio tempus lacus pretium fermentum. ',
        maxLines: 12,
        overflow: TextOverflow.ellipsis,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.left,
        style: theme.textTheme.bodyText2,
      ),
    );

    final aboutTheClient = Container(
      color: theme.backgroundColor,
      padding: EdgeInsets.all(12.0),
      //margin: EdgeInsets.all(12.0),
      child: Flex (
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'About The Client',
            textAlign: TextAlign.left,
            style: theme.textTheme.bodyText1,
          ),
          SizedBox(height: 10.0),
          Opacity (
            opacity: 0.64,
            child: Text(
              'Member since DD-MM-YYYY',
              textAlign: TextAlign.left,
              style: theme.textTheme.bodyText2,
            ),
          ),
          Flex (
            direction: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Expanded (
                  flex: 3,
                  child: Flex (
                    direction: Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget> [
                      SizedBox(height: 20.0),
                      Container(
                        height: 1.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(
                              color: Color.fromRGBO(186, 207, 216, 1),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Flex (
                        direction: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget> [
                          Expanded(
                            flex: 1,
                            child: CircleAvatar(
                              //backgroundColor: Color(0xff0075ff),
                              radius: 12,
                              child: Center (
                                  child: Image.asset(
                                    'packages/local_people_core/assets/images/verified-icon.png',
                                    fit: BoxFit.contain,
                                    height: 22,
                                    width: 22,
                                  )
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 6,
                              child: Text(
                                'Payment Method Verified',
                                textAlign: TextAlign.left,
                                style: theme.textTheme.bodyText1,
                              ),
                          )
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Flex (
                        direction: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget> [
                          Expanded(
                            flex: 1,
                            child: CircleAvatar(
                              //backgroundColor: Color(0xff0075ff),
                              radius: 12,
                              child: Center (
                                  child: Image.asset(
                                    'packages/local_people_core/assets/images/verified-icon.png',
                                    fit: BoxFit.contain,
                                    height: 23,
                                    width: 23,
                                  )
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 6,
                              child: Flex (
                                direction: Axis.vertical,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget> [
                                  Text(
                                    'XX Jobs Posted',
                                    textAlign: TextAlign.left,
                                    style: theme.textTheme.bodyText1,
                                  ),
                                  Opacity (
                                    opacity: 0.84,
                                    child: Text(
                                      'YY jobs commissioned',
                                      textAlign: TextAlign.left,
                                      style: theme.textTheme.bodyText2,
                                    ),
                                  )
                                ],
                              )
                          )
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Flex (
                        direction: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget> [
                          Expanded(
                            flex: 1,
                            child: CircleAvatar(
                              //backgroundColor: Color(0xff0075ff),
                              radius: 12,
                              child: Center (
                                  child: Image.asset(
                                    'packages/local_people_core/assets/images/verified-icon.png',
                                    fit: BoxFit.contain,
                                    height: 23,
                                    width: 23,
                                  )
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 6,
                              child: Flex (
                                direction: Axis.vertical,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget> [
                                  Text(
                                    "\$" + 'XXX Spent',
                                    textAlign: TextAlign.left,
                                    style: theme.textTheme.bodyText1,
                                  ),
                                ],
                              )
                          ),
                        ],
                      ),
                    ],
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
      child: Container (
        height: 400,
      )
    );

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
        child: SmoothStarRating (
            allowHalfRating: false,
            onRated: (v) {},
            starCount: 5,
            rating: 100,
            size: 32.0,
            isReadOnly:true,
            //fullRatedIconData: Icons.blur_off,
            //halfRatedIconData: Icons.blur_on,
            color: Color.fromRGBO(255, 99, 97, 1),
            borderColor: Color.fromRGBO(255, 99, 97, 1),
            spacing:0.0
        ),
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
        child: Container (
          height: 300,
        )
    );

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
      introductionActions, introduction,
      aboutTheClient,
      recentJobs, recentJobItems,
      reviewsGiven, reviewsGivenItems,
      recommendations, recommendationItems
    ];

    Widget bodyContent = SliverList (
        delegate: new SliverChildListDelegate(
            columnChildren,
        ),
    );


    return bodyContent;

  }
  
}