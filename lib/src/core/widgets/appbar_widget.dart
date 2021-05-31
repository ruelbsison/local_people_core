import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'logo_widget.dart';
import '../utils/date_format.dart';
import 'spacer_widget.dart';
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
    this.subTitle, this.bottom, this.appBarPreferredSize = const Size.fromHeight(138.0)})
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
        //actions: actions,
        bottom: PreferredSize (
          preferredSize: Size(size.width, appBarPreferredSize.height),
          child: Flex (
            direction: Axis.vertical,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget> [
              Row (
                children: [
                  Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                            child: Container (
                              padding: EdgeInsets.only(left: 10),
                              //padding: EdgeInsets.only(left: 12, top: 40),
                              child: LogoWidget(
                                fit: BoxFit.contain,
                                height: 52,
                                //width: 105 * mediaQueryData.devicePixelRatio,
                              ),
                              //color: Colors.green,
                          ),
                      ),
                  ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding (
                          padding: EdgeInsets.only(right: 14),
                          child: (actions != null && actions.length > 0) ? actions[0] : Container(),
                        )
                      ),
                    ),
                ],
              ),
              SizedBox(height: 10),
              Container (
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  subTitle,
                  textAlign: TextAlign.left,
                  style: headline6Style,
                ),
                //color: Colors.yellow,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
        //bottom: bottom,
        // title: Flex (
        //   direction: Axis.vertical,
        //   mainAxisSize: MainAxisSize.max,
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: <Widget> [
        //     Container (
        //       padding: EdgeInsets.only(left: 10),
        //       //padding: EdgeInsets.only(left: 12, top: 40),
        //       child: LogoWidget(
        //           fit: BoxFit.contain,
        //           height: 22,
        //         //width: 105 * mediaQueryData.devicePixelRatio,
        //       ),
        //       //color: Colors.green,
        //     ),
        //     Container (
        //       padding: EdgeInsets.only(left: 12),
        //       child: Text(
        //         subTitle,
        //         textAlign: TextAlign.left,
        //         style: headline6Style,
        //       ),
        //       //color: Colors.yellow,
        //     )
        //   ],
        // ),
        elevation: 0.0,
        //bottom: bottom,
      ),
    );
  }

  @override
  Size get preferredSize => appBarPreferredSize;
}
