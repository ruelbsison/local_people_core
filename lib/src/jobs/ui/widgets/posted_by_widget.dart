import 'package:flutter/material.dart';
import 'package:local_people_core/profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_people_core/profile.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class PostedByWidget extends StatefulWidget {
  PostedByWidget({
    Key key,
    @required this.clientId,
  }) : super(key: key);

  //final ClientProfile profile = ClientProfile.empty;
  final int clientId;
  @override
  _PostedByWidgetState createState() => _PostedByWidgetState();
}

class _PostedByWidgetState extends State<PostedByWidget> {
  @override
  Widget build(BuildContext context) {
    final appType = AppConfig.of(context).appType;
    // try {
    //   ClientProfile clientProfile = sl<ClientProfile>();
    //   if (clientProfile  != null)
    //     return buildContent(clientProfile);
    // } catch(e) {
    //   print(e.toString());
    // }
    return BlocProvider(
      create: (context) => ProfileBloc(
        profileRepository: RepositoryProvider.of<ProfileRepository>(context),
        appType: appType,
        authLocalDataSource: sl<AuthLocalDataSource>(),
      )..add(ClientProfileGetEvent(id: widget.clientId)),
      child: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        if (state is ClientProfileGetLoaded) {
          //locatorAddClientProfile(state.profile);
          return buildContent(state.profile);
        } else if (state is ClientProfileGetFailed) {
          return ErrorWidget('Error $state');
        } else {
          return LoadingWidget();
        }
      }),
    );
  }

  Widget buildContent(ClientProfile profile) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(12.0),
      // decoration: BoxDecoration(
      //   color: Color.fromRGBO(255, 255, 255, 1),
      //   borderRadius: BorderRadius.circular(5.0),
      // ),
      //height: 197,
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'Posted By',
            textAlign: TextAlign.left,
            style: textTheme.subtitle1,
          ),
          SizedBox(height: 20.0),
          Flex(
            direction: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    ClipOval (
                      child: CachedNetworkImage(
                        imageUrl: profile.photo,
                        width: 75,
                        height: 75,
                        placeholder: (context, url) => LoadingWidget(
                          isImage: true,
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          'packages/local_people_core/assets/images/trader-profile-photo.png',
                          fit: BoxFit.cover,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 5,
                  child: Flex(
                    direction: Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        (profile.fullName != null
                            ? profile.fullName
                            : 'Client Full Name'),
                        textAlign: TextAlign.left,
                        style: textTheme.subtitle1,
                      ),
                      Text(
                        'Member since ' +
                            DateFormat('dd-MM-yyyy')
                                .format(profile.memberSince),
                        textAlign: TextAlign.left,
                        style: textTheme.overline,
                      ),
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
                      Flex(
                        direction: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: CircleAvatar(
                              //backgroundColor: Color(0xff0075ff),
                              radius: 8,
                              child: Center(
                                  child: Image.asset(
                                'packages/local_people_core/assets/images/verified-icon.png',
                                fit: BoxFit.contain,
                                height: 15,
                                width: 15,
                              )),
                            ),
                          ),
                          Expanded(
                              flex: 6,
                              child: Flex(
                                direction: Axis.vertical,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Payment Method ' +
                                        (profile.paymentMethodVerified == true
                                            ? 'Verified'
                                            : 'Not Verified'),
                                    textAlign: TextAlign.left,
                                    style: textTheme.bodyText1,
                                  ),
                                  Text(
                                    'Member since ' +
                                        DateFormat('dd-MM-yyyy')
                                            .format(profile.memberSince),
                                    textAlign: TextAlign.left,
                                    style: textTheme.bodyText2,
                                  ),
                                ],
                              ))
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Flex(
                        direction: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: CircleAvatar(
                              //backgroundColor: Color(0xff0075ff),
                              radius: 8,
                              child: Center(
                                  child: Image.asset(
                                'packages/local_people_core/assets/images/verified-icon.png',
                                fit: BoxFit.contain,
                                height: 15,
                                width: 15,
                              )),
                            ),
                          ),
                          Expanded(
                              flex: 6,
                              child: Flex(
                                direction: Axis.vertical,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    profile.numOfJobsPosted.toString() +
                                        ' Jobs Posted',
                                    textAlign: TextAlign.left,
                                    style: textTheme.bodyText1,
                                  ),
                                  Text(
                                    profile.amountSpent.toString() +
                                        ' Jobs commissioned',
                                    textAlign: TextAlign.left,
                                    style: textTheme.bodyText2,
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
