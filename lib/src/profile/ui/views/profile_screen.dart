import 'package:local_people_core/core.dart';

import 'package:flutter/material.dart';
import '../widgets/profile_client_body.dart';
import '../widgets/profile_trader_body.dart';
import '../../domain/entities/client_profile.dart';
import '../../domain/entities/trader_profile.dart';
import 'package:sliver_fab/sliver_fab.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileScreen extends StatefulWidget {
  final dynamic profile;
  final dynamic otherProfile;
  ProfileScreen({
    Key key,
    @required this.profile,
    this.otherProfile,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    final appType = AppConfig.of(context).appType;
    //Widget topContent = (appType == AppType.CLIENT ? ProfileClientHeader(profile: new ClientProfile()) : ProfileTraderHeader(profile: new TraderProfile()));
    // TODO:: Ruel
    Widget bodyContent = (widget.profile is ClientProfile //appType == AppType.CLIENT
        ? ProfileClientBody(profile: widget.profile)
        : ProfileTraderBody(profile: widget.profile, clientProfile: widget.otherProfile,));
    // return Scaffold(
    //   appBar: buildAppBar(context),
    //   body: bodyContent,
    // );
    return new Scaffold(
      body: new Builder(
        builder: (context) =>
        //new CustomScrollView (
        new SliverFab(
          floatingWidget: FloatingActionButton(
            onPressed: () => {},
                //Scaffold.of(context).showSnackBar(
                //    SnackBar(content: Text("You clicked!"))),
            child: Icon(Icons.add),
          ),
          floatingPosition: FloatingPosition(right: 16),
          expandedHeight: 256.0,
          slivers: <Widget>[
            new SliverAppBar(
              expandedHeight: 256.0,
              pinned: true,
              titleSpacing: 0,
              centerTitle: false,
              flexibleSpace: new FlexibleSpaceBar(
                //title: Text("Profile"),
                background: CachedNetworkImage(
                  imageUrl: widget.profile.photo,
                  placeholder: (context, url) => LoadingWidget(
                    isImage: true,
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'packages/local_people_core/assets/images/trader-profile-photo.png',
                    fit: BoxFit.cover,
                  ),
                  fit: BoxFit.cover,
                ),
                //background: Image.asset(
                //  widget.profile.photo,
                  //(appType == AppType.CLIENT
                  //    ? 'packages/local_people_core/assets/images/client-profile-photo.png'
                  //    : 'packages/local_people_core/assets/images/trader-profile-photo.png'),
                //  fit: BoxFit.cover,
                //),
              ),
              bottom: PreferredSize (
                preferredSize: Size(size.width, 100.0),
                child: Flex (
                  direction: Axis.vertical,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget> [
                    Container (
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        widget.profile != null && widget.profile.fullName != null ? widget.profile.fullName : '',
                        style: theme.textTheme.headline6.copyWith(color: Colors.white),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container (
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'SkyFields',
                        style: theme.textTheme.subtitle1.copyWith(color: Colors.white),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container (
                      padding: EdgeInsets.only(left: 10),
                      child: SmoothStarRating (
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
