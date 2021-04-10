import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'logo_widget.dart';
import '../utils/date_format.dart';

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
    final headline6Style = Theme.of(context).textTheme.headline6;
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final Size size = MediaQuery.of(context).size;
    return PreferredSize(
      preferredSize: Size.fromHeight(120.0),
      child: AppBar(
        automaticallyImplyLeading: false, // Don't show the leading button
        titleSpacing: 0,
        centerTitle: false,
        /*title: Container(
          width: size.width,
          padding: EdgeInsets.only(top: 20, left: 12),
          //color: Colors.green,
          alignment: Alignment.centerLeft,
          child: LogoWidget(
            fit: BoxFit.contain,
            height: 40 * mediaQueryData.devicePixelRatio,
            //width: 105 * mediaQueryData.devicePixelRatio,
          ),
        ),*/
        flexibleSpace: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              padding: EdgeInsets.only(top: 20, left: 12),
              //color: Colors.green,
              alignment: Alignment.centerLeft,
              child: LogoWidget(
                fit: BoxFit.contain,
                height: 40 * mediaQueryData.devicePixelRatio,
                //width: 105 * mediaQueryData.devicePixelRatio,
              ),
            ),
          ],
        ),
        elevation: 0.0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Container(
            //margin: EdgeInsets.only(top: 12.0, bottom: 12.0),
            padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
            child: Text(
              //DateFormat('dd MMMM yyyy').format(DateTime.now()),  //+ ' (' + size.width.toString() + 'x' + size.height.toString() + ')',
              DateFormatUtil.getFormattedDate(),
              textAlign: TextAlign.left,
              style: headline6Style,
            ),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Color.fromRGBO(186, 207, 216, 1),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(120.0);
}
