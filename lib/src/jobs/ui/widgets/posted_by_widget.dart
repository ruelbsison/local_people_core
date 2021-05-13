import 'package:flutter/material.dart';
import  'package:local_people_core/profile.dart';


class PostedByWidget extends StatefulWidget {
  PostedByWidget({
    Key key,
  }) : super(key: key);

  // TODO: Ruel
  final ClientProfile profile = ClientProfile.empty;

  @override
  _PostedByWidgetState createState() => _PostedByWidgetState();
}

class _PostedByWidgetState extends State<PostedByWidget> {

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return  Container(
      color: Colors.white,
      padding: EdgeInsets.all(12.0),
      // decoration: BoxDecoration(
      //   color: Color.fromRGBO(255, 255, 255, 1),
      //   borderRadius: BorderRadius.circular(5.0),
      // ),
      //height: 197,
      child: Flex (
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
          Flex (
            direction: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Expanded (
                flex: 1,
                child: CircleAvatar(
                  child: FlutterLogo(size: 75),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget> [
                      Text(
                        (widget.profile.fullName != null ? widget.profile.fullName : 'Client Full Name'),
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
                                    'Payment Method Verified',
                                    textAlign: TextAlign.left,
                                    style: textTheme.subtitle1,
                                  ),
                                  Text(
                                    'Member since DD-MM-YYYY',
                                    textAlign: TextAlign.left,
                                    style: textTheme.bodyText1,
                                  ),
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
                          )
                        ],
                      ),
                    ],
                  )
              ),
            ],
          ),
        ],
      ),
    );
  }
}
