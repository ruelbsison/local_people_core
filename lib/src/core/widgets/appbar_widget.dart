import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'logo_widget.dart';
import '../utils/date_format.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = Colors.white;
  final Widget title;
  final String subTitle;
  final AppBar appBar;
  final List<Widget> actions;
  final PreferredSizeWidget bottom;
  final Size appBarPreferredSize;
  /// you can add more fields that meet your needs

  const AppBarWidget({Key key, 
    this.title, this.appBar, this.actions,
    this.subTitle, this.bottom, this.appBarPreferredSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headline6Style = Theme.of(context).textTheme.headline6;
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final Size size = MediaQuery.of(context).size;
    return PreferredSize(
      preferredSize: appBarPreferredSize,
      child: AppBar(
        //automaticallyImplyLeading: false, // Don't show the leading button
        titleSpacing: 0,
        centerTitle: false,
        actions: actions,
        title: Flex (
          direction: Axis.vertical,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Container (
              padding: EdgeInsets.only(left: 10),
              //padding: EdgeInsets.only(left: 12, top: 40),
              child: LogoWidget(
                  fit: BoxFit.contain,
                  height: 22,
                //width: 105 * mediaQueryData.devicePixelRatio,
              ),
              //color: Colors.green,
            ),
            Container (
              padding: EdgeInsets.only(left: 12),
              child: Text(
                subTitle,
                textAlign: TextAlign.left,
                style: headline6Style,
              ),
              //color: Colors.yellow,
            )
          ],
        ),
        elevation: 0.0,
        bottom: bottom,
      ),
    );
  }

  @override
  Size get preferredSize => appBarPreferredSize;
}
