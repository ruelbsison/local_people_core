import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'logo_widget.dart';
import '../utils/date_format.dart';
import 'spacer_widget.dart';

typedef FilterValueChanged = void Function(String);

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = Colors.white;
  final String title;
  final String subTitle;
  final AppBar appBar;
  final List<Widget> actions;
  final PreferredSizeWidget bottom;
  final Size appBarPreferredSize;
  final bool showFilter;
  final List<String> filterItems;
  final String filterValue;
  final FilterValueChanged onFilterValueChanged;
  final String searchTitle;

  /// you can add more fields that meet your needs

  const AppBarWidget({
    Key key,
    this.title = null,
    this.appBar,
    this.actions,
    this.subTitle,
    this.bottom,
    this.appBarPreferredSize = const Size.fromHeight(260.0),
    this.showFilter = false,
    this.filterItems = const [],
    this.filterValue = '',
    this.onFilterValueChanged = null,
    this.searchTitle = null,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final headline6Style = Theme.of(context).textTheme.headline6;
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final Size size = MediaQuery.of(context).size;
    final double statusbarHeight = MediaQuery
        .of(context)
        .padding
        .top;
    return PreferredSize(
      preferredSize: appBarPreferredSize,
      child: AppBar(
        //automaticallyImplyLeading: false, // Don't show the leading button
        // leading: LogoWidget(
        //   fit: BoxFit.contain,
        //   height: 40,
        //   //width: 105 * mediaQueryData.devicePixelRatio,
        // ),
        leadingWidth: 40,
        title: LogoWidget(
          fit: BoxFit.contain,
          height: 40,
          //width: 105 * mediaQueryData.devicePixelRatio,
        ),
        titleSpacing: 0,
        centerTitle: false,
        actions: actions,
        //expandedHeight: 300.0,
        flexibleSpace: PreferredSize(
          preferredSize: Size(size.width, appBarPreferredSize.height),
          child: Container(
          padding: EdgeInsets.only(top: statusbarHeight + 50),
          child: Flex(
            direction: Axis.vertical,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 5),
              if (title != null || subTitle != null || showFilter == true)
                buildTitleContent(context),
              if (title != null || subTitle != null || showFilter == true)
                SizedBox(height: 3),
              if (subTitle != null)
                buildSubTitle(context),
              if (subTitle != null)
                SizedBox(height: 3),
              if (searchTitle != null)
                buildSearchContent(context),
              if (searchTitle != null)
                SizedBox(height: 3),
              if (bottom != null)
                bottom,
              //SizedBox(height: 10),
            ],
          ),
          ),
        ),
        elevation: 0.0,
      ),
    );
  }

  Widget buildSubTitle(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Text(
        subTitle, //"140 Opportunities in your area today  ",
        style: theme.textTheme.bodyText1,
      ),
    );
  }

  Widget buildSearchContent(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Color(0xffeff4f6),
        ),
        child: TextField(
          decoration: InputDecoration(
            hintStyle: theme.textTheme.bodyText2,
            hintText: searchTitle, //'Search Opportunities',
            suffixIcon: Icon(
                Icons.search,
              color: Color(0xffff6361),
            ),
            // suffix:  Stack (
            //   children: [
            //     Container(
            //       width: 30,
            //       height: 30,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(35),
            //         color: Color(0xffff6361),
            //       ),
            //       child: Icon(
            //         Icons.search,
            //         color: Color(0xffff6361),
            //       ),
            //     ),
            //   ],
            // ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(12),
            ),
          //textAlign: TextAlign.center,
          style: theme.textTheme.bodyText2,
        ),
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
                title,
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
    } else if (subTitle != null) {
      return Container(
        padding: EdgeInsets.only(left: 12),
        child: Text(
          subTitle != null ? subTitle : '',
          textAlign: TextAlign.left,
          style: theme.headline6,
        ),
        //color: Colors.yellow,
      );
    } else {
      return Container(
        padding: EdgeInsets.only(left: 12),
        child: Text(
          title,
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
