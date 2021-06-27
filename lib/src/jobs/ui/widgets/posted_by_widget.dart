import 'package:flutter/material.dart';
import 'package:local_people_core/profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_people_core/profile.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget> [
          Text(
            'Posted By',
            textAlign: TextAlign.left,
            style: textTheme.subtitle1,
          ),
          SizedBox(height: 10.0),
          Container(
            color: Colors.white,
            child: Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
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
                              width: 65,
                              height: 65,
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
                        flex: 6,
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: CircleAvatar(
                                    backgroundColor: Color(0x00000000),
                                    radius: 8,
                                    child: Center(
                                      child: SvgPicture.asset(
                                        'packages/local_people_core/assets/images/verified.svg',
                                        fit: BoxFit.contain,
                                        height: 15,
                                        width: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 7,
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
                                          style: textTheme.subtitle2,
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
                                    backgroundColor: Color(0x00000000),
                                    radius: 8,
                                    child: Center(
                                      child: SvgPicture.asset(
                                        'packages/local_people_core/assets/images/verified.svg',
                                        fit: BoxFit.contain,
                                        height: 15,
                                        width: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 7,
                                    child: Flex(
                                      direction: Axis.vertical,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          profile.numOfJobsPosted.toString() +
                                              ' Jobs Posted',
                                          textAlign: TextAlign.left,
                                          style: textTheme.subtitle2,
                                        ),
                                        Text(
                                          profile.amountSpent.toString() +
                                              ' Jobs commissioned',
                                          textAlign: TextAlign.left,
                                          style: textTheme.bodyText2,
                                        ),
                                      ],
                                    ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.0),
                          ],
                        )
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
    );
  }
}
