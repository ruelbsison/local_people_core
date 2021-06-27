import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui';

//class AppDialog extends StatefulWidget {
class AppDialog extends StatelessWidget {
  final Widget child;
  final String title;

  AppDialog({
    Key key,
    @required this.title,
    @required this.child,
  }) : super(key: key);

  double deviceWidth;
  double deviceHeight;
  double dialogHeight;

//   @override
//   _AppDialogState createState() => _AppDialogState();
// }
//
// class _AppDialogState extends State<AppDialog> {
  @override
  Widget build(BuildContext context) {

    Orientation orientation = MediaQuery.of(context).orientation;
    Size viewsSize = MediaQuery.of(context).size;

    deviceWidth = orientation == Orientation.portrait
        ? viewsSize.width
        : viewsSize.height;
    deviceHeight = orientation == Orientation.portrait
        ? viewsSize.height
        : viewsSize.width;
    dialogHeight = deviceHeight * (0.50);

    return MediaQuery(
      data: MediaQueryData(),
      child: GestureDetector(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 0.5,
            sigmaY: 0.5,
          ),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Container(
                          width: deviceWidth * 0.9,
                          child: GestureDetector(
                            onTap: () {},
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: buildContent(context),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    final theme = Theme.of(context);
    //final size = MediaQuery.of(context).size;
    // return Container(
    //   padding: EdgeInsets.all(12.0),
    //   decoration: BoxDecoration(
    //     color: theme.primaryColor,
    //     borderRadius: BorderRadius.circular(8.0),
    //     shape: BoxShape.rectangle,
    //   ),
    //   child: Column(
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card (
            elevation: 0,
            color: Color.fromRGBO(239, 244, 246, 1),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title,
                        textAlign: TextAlign.left,
                        style: theme.textTheme.subtitle1,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    //color: Color.fromRGBO(239, 244, 246, 1),
                    //padding: EdgeInsets.only(right: 10),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        //padding: EdgeInsets.all(2.0),
                        icon: SvgPicture.asset(
                          'packages/local_people_core/assets/images/minus.svg',
                          height: 24,
                          width: 24,
                        ),
                        iconSize: 24,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            // padding: EdgeInsets.all(20.0),
            child: Card (
              elevation: 0,
              margin: EdgeInsets.all(0.0),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: child,
              ),
            ),
          ),
        ],
      //),
    );
  }
}
