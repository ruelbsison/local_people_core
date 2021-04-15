import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_people_core/core.dart';
import 'locations_view_widget.dart';
import 'tags_view_widget.dart';
import 'package:flutter_icons/flutter_icons.dart';
import '../views/job_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import  '../../domain/entities/profile.dart';


class PostedByWidget extends StatefulWidget {
  PostedByWidget({
    Key key,
    @required this.profile,
  }) : super(key: key);

  final Profile profile;

  @override
  _PostedByWidgetState createState() => _PostedByWidgetState();
}

class _PostedByWidgetState extends State<PostedByWidget> {

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return  Container(
      padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
      margin: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.circular(5.0),
      ),
      //height: 197,
      child: Flex (
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          Expanded (
            flex: 1,
            child: CircleAvatar(
              /*child: CachedNetworkImage(
                    imageUrl: widget.profile.photoUrl,
                    placeholder: (context, url) => LoadingWidget(
                      isImage: true,
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      'packages/local_people_core/assets/images/local-people-logo.png',
                      fit: BoxFit.cover,
                    ),
                    fit: BoxFit.cover,
                  ),*/
            ),
          ),
          Expanded (
              flex: 3,
              child: Flex (
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget> [
                  Text(
                    widget.profile.fullName,
                    textAlign: TextAlign.left,
                    style: textTheme.subtitle1,
                  ),
                  Text(
                    'Member since DD-MM-YYYY',
                    textAlign: TextAlign.left,
                    style: textTheme.bodyText1,
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
                  Text(
                    'Payment Method Verified',
                    textAlign: TextAlign.left,
                    style: textTheme.subtitle1,
                  ),
                  Text(
                    'Member since DD-MM-YYYY',
                    textAlign: TextAlign.left,
                    style: textTheme.bodyText1,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'XX Jobs Posted',
                    textAlign: TextAlign.left,
                    style: textTheme.subtitle1,
                  ),
                  Text(
                    'YY Jobs commissioned',
                    textAlign: TextAlign.left,
                    style: textTheme.bodyText1,
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }
}
