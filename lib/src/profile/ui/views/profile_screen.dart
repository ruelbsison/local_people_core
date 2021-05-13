import 'package:local_people_core/core.dart';

import 'package:flutter/material.dart';
//import '../widgets/profile_client_header.dart';
import '../widgets/profile_client_body.dart';
//import '../widgets/profile_trader_header.dart';
import '../widgets/profile_trader_body.dart';
import '../../domain/entities/client_profile.dart';
import '../../domain/entities/trader_profile.dart';
//import 'package:permission_handler/permission_handler.dart';
import 'package:sliver_fab/sliver_fab.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  // void requestPermission() async {
  //   Map<Permission, PermissionStatus> statuses =
  //   await [Permission.location].request();
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //
  //   requestPermission();
  // }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    final appType = AppConfig.of(context).appType;
    //Widget topContent = (appType == AppType.CLIENT ? ProfileClientHeader(profile: new ClientProfile()) : ProfileTraderHeader(profile: new TraderProfile()));
    // TODO:: Ruel
    Widget bodyContent = (appType == AppType.CLIENT
        ? ProfileClientBody(profile: new ClientProfile())
        : ProfileTraderBody(profile: new TraderProfile()));
    // return Scaffold(
    //   appBar: buildAppBar(context),
    //   body: bodyContent,
    // );
    return new Scaffold(
      body: new Builder(
        builder: (context) =>
        new SliverFab(
          floatingWidget: FloatingActionButton(
            onPressed: () =>
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text("You clicked FAB!"))),
            child: Icon(Icons.add),
          ),
          floatingPosition: FloatingPosition(right: 16),
          expandedHeight: 256.0,
          slivers: <Widget>[
            new SliverAppBar(
              expandedHeight: 256.0,
              pinned: true,
              flexibleSpace: new FlexibleSpaceBar(
                title: Text("Profile"),
                background: Image.asset(
                  (appType == AppType.CLIENT
                      ? 'packages/local_people_core/assets/images/client-profile-photo.png'
                      : 'packages/local_people_core/assets/images/trader-profile-photo.png'),
                  fit: BoxFit.cover,
                ),
              ),
              bottom: PreferredSize (
                preferredSize: Size(size.width, 100.0),
                child: Flex (
                  direction: Axis.vertical,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    Text(
                      (appType == AppType.CLIENT
                          ? 'Client\'s Name Goes Here'
                          : 'Trader\'s Name Goes Here'),
                      style: theme.textTheme.headline6,
                    ),
                    Text(
                      'SkyFields',
                      style: theme.textTheme.subtitle1,
                    ),
                    SmoothStarRating (
                        allowHalfRating: false,
                        onRated: (v) {},
                        starCount: 5,
                        rating: 100,
                        size: 20.0,
                        isReadOnly:true,
                        //fullRatedIconData: Icons.blur_off,
                        //halfRatedIconData: Icons.blur_on,
                        color: Color.fromRGBO(255, 99, 97, 1),
                        borderColor: Color.fromRGBO(255, 99, 97, 1),
                        spacing:0.0
                    ),
                  ],
                ),
              )
            ),
            bodyContent,
            // new SliverList(
            //   delegate: new SliverChildListDelegate(
            //     new List.generate(
            //       30,
            //           (int index) =>
            //       new ListTile(title: new Text("Item $index")),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  // PreferredSizeWidget buildAppBar(BuildContext context) {
  //   final theme = Theme.of(context);
  //   return AppBar(
  //     title: Text(
  //       'Profile',
  //       textAlign: TextAlign.left,
  //       style: theme.textTheme.headline6,
  //     ),
  //     elevation: 0.0,
  //   );
  // }
}
