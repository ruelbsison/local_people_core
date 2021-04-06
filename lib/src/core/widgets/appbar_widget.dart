import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'logo_widget.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = Colors.white;
  final Widget title;
  final AppBar appBar;
  final List<Widget> actions;

  /// you can add more fields that meet your needs

  const AppBarWidget({Key key, this.title, this.appBar, this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final Size size = MediaQuery.of(context).size;
    return AppBar(
      automaticallyImplyLeading: false, // Don't show the leading button
      titleSpacing: 8,
      centerTitle: false,
      backgroundColor: backgroundColor,
      title: LogoWidget(
        fit: BoxFit.contain,
        height: AppBar().preferredSize.height * 2,
      ),
      /*title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          LogoWidget(
            fit: BoxFit.contain,
            height: AppBar().preferredSize.height * 2,
          ),
        ]
      ),*/
      actions: actions,
      bottom: PreferredSize (
        preferredSize: Size(double.infinity, 20),
        child: SafeArea (
          child: Container (
            // padding: EdgeInsets.all(16.0),
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              DateFormat.yMMMMEEEEd().format(DateTime.now()),  //+ ' (' + size.width.toString() + 'x' + size.height.toString() + ')',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
                fontFamily: 'Inter',
                fontSize: 16,
                letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                fontWeight: FontWeight.bold,
              ),
            ),
            alignment: Alignment.centerLeft,
          ),
        ),
        // preferredSize: Size.fromHeight(20.0),
      )
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height + 20);
}