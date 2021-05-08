import 'package:local_people_core/core.dart';

import 'package:flutter/material.dart';
import '../widgets/profile_client_header.dart';
import '../widgets/profile_client_body.dart';
import '../widgets/profile_trader_header.dart';
import '../widgets/profile_trader_body.dart';
import '../../domain/entities/client_profile.dart';
import '../../domain/entities/trader_profile.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  void requestPermission() async {
    Map<Permission, PermissionStatus> statuses =
    await [Permission.location, Permission.locationAlways, Permission.locationWhenInUse].request();
  }

  @override
  void initState() {
    super.initState();

    requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    final appType = AppConfig.of(context).appType;
    //Widget topContent = (appType == AppType.CLIENT ? ProfileClientHeader(profile: new ClientProfile()) : ProfileTraderHeader(profile: new TraderProfile()));
    // TODO:: Ruel
    Widget bodyContent = (appType == AppType.CLIENT
        ? ProfileClientBody(profile: new ClientProfile())
        : ProfileTraderBody(profile: new TraderProfile()));
    return Scaffold(
      appBar: buildAppBar(context),
      body: bodyContent,
    );
  }

  PreferredSizeWidget buildAppBar(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      title: Text(
        'Profile',
        textAlign: TextAlign.left,
        style: theme.textTheme.headline6,
      ),
      elevation: 0.0,
    );
  }
}
