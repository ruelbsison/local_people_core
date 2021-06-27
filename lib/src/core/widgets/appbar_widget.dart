import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'logo_widget.dart';
import '../utils/date_format.dart';
import 'spacer_widget.dart';

typedef FilterValueChanged = void Function(String);

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = Colors.white;
  final Widget title;
  final String subTitle;
  final AppBar appBar;
  final List<Widget> actions;
  final PreferredSizeWidget bottom;
  final Size appBarPreferredSize;
  final bool showFilter;
  final List<String> filterItems;
  final String filterValue;
  final FilterValueChanged onFilterValueChanged;

  /// you can add more fields that meet your needs

  const AppBarWidget({
    Key key,
    this.title,
    this.appBar,
    this.actions,
    this.subTitle,
    this.bottom,
    this.appBarPreferredSize = const Size.fromHeight(110.0),
    this.showFilter = false,
    this.filterItems = const [],
    this.filterValue = '',
    this.onFilterValueChanged = null,
  }) : super(key: key);

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
        flexibleSpace: PreferredSize(
          preferredSize: Size(size.width, appBarPreferredSize.height),
          child: Flex(
            direction: Axis.vertical,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 2,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.only(
                              left: 10,
                              top: 12,
                            ),
                            child: LogoWidget(
                              fit: BoxFit.contain,
                              //height: 30,
                              //width: 105 * mediaQueryData.devicePixelRatio,
                            ),
                            //color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 14),
                          child: (actions != null && actions.length > 0)
                              ? actions[0]
                              : Container(),
                        )),
                  ),
                ],
              ),
              //SizedBox(height: 10),
              buildTitleContent(context),
              //SizedBox(height: 10),
            ],
          ),
        ),
        bottom: bottom,
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
      ),
    );
  }

  Widget buildTitleContent(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    if (showFilter == true) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 12),
              child: Text(
                subTitle,
                textAlign: TextAlign.left,
                style: theme.headline6,
              ),
              //color: Colors.yellow,
            ),
          ),
          Expanded(
            flex: 1,
            //SingleChildScrollView
            child: SingleChildScrollView(
              padding: EdgeInsets.only(right: 12),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: Text("Filter by"),
                  focusColor: Color.fromRGBO(96, 106, 129, 1.0),
                  items: filterItems.map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value, style: theme.subtitle2),
                    );
                  }).toList(),
                  value: filterValue,
                  onChanged: (newValue) {
                    if (onFilterValueChanged != null) {
                      onFilterValueChanged(newValue);
                    }
                    // setState(() {
                    //   _sortValue = newValue;
                    // });
                  },
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Container(
        padding: EdgeInsets.only(left: 12),
        child: Text(
          subTitle,
          textAlign: TextAlign.left,
          style: theme.headline6,
        ),
        //color: Colors.yellow,
      );
    }
  }

  @override
  Size get preferredSize => appBarPreferredSize;
}
