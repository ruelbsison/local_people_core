import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'logo_widget.dart';
import '../utils/date_format.dart';
import 'spacer_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

typedef FilterValueChanged = void Function(String);

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final Color backgroundColor = Colors.white;
  final String title;
  String subTitle;
  final AppBar appBar;
  final List<Widget> actions;
  final PreferredSizeWidget bottom;
  final Size appBarPreferredSize;
  final bool showFilter;
  final List<String> filterItems;
  final String filterValue;
  final FilterValueChanged onFilterValueChanged;
  final String searchTitle;
  final Size preferredSize;// = const Size.fromHeight(260.0);
  /// you can add more fields that meet your needs

  AppBarWidget({
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
  }) : preferredSize = appBarPreferredSize, super(key: key);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final headline6Style = Theme.of(context).textTheme.headline6;
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final Size size = MediaQuery.of(context).size;
    double statusbarHeight = MediaQuery
        .of(context)
        .padding
        .top;
    NavigatorState state = Navigator.of(context);
    print('NavigatorState: ' + state.canPop().toString());
    if (state.canPop() == true) {
      statusbarHeight = statusbarHeight * 3;
    }
    return PreferredSize(
      preferredSize: widget.appBarPreferredSize,
      child: AppBar(
        //automaticallyImplyLeading: false, // Don't show the leading button
        // title: Builder(
        // builder: (BuildContext context) {
        //   NavigatorState state = Navigator.of(context);
        //   //print('NavigatorState: ' + state.canPop().toString());
        //   if (state.canPop() == false)
        //     return Container(height: 0,width: 0,);
        //   return Row(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: <Widget>[
        //       IconButton(
        //         onPressed: () => Navigator.pop(context),
        //         icon: Icon(Icons.arrow_back, color: Colors.black),
        //       ),
        //       // Your widgets here
        //     ],
        //   );
        // },),
        leadingWidth: 30,
        titleSpacing: 0,
        centerTitle: false,
        //actions: widget.actions,
        //expandedHeight: 300.0,
        flexibleSpace: PreferredSize(
          preferredSize: Size(size.width, widget.appBarPreferredSize.height),
          child: Container(
          padding: EdgeInsets.only(top: statusbarHeight, right: 10.0),
          //width: size.width,
          //height: widget.appBarPreferredSize.height,
          child: Flex(
            direction: Axis.vertical,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 5),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: LogoWidget(
                          fit: BoxFit.fitHeight,
                          height: 40,
                        ),
                      ),
                    ),
                  ),
                  if (widget.actions != null && widget.actions.length > 0)
                    widget.actions[0]
                  // Expanded(
                  //   flex: 1,
                  //   child: Align(
                  //       alignment: Alignment.centerRight,
                  //       child: Padding(
                  //         padding: EdgeInsets.only(right: 12),
                  //         child: Row(
                  //           mainAxisSize: MainAxisSize.min,
                  //           crossAxisAlignment: CrossAxisAlignment.stretch,
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: widget.actions != null && widget.actions.length > 0
                  //               ?  widget.actions : [Container(height: 0,width: 0,)],
                  //         )
                  //       )
                  //   ),
                  // ),
                ],
              ),
              if (widget.title != null || widget.subTitle != null || widget.showFilter == true)
                buildTitleContent(context),
              if (widget.title != null || widget.subTitle != null || widget.showFilter == true)
                SizedBox(height: 3),
              if (widget.subTitle != null)
                buildSubTitle(context),
              if (widget.subTitle != null)
                SizedBox(height: 3),
              if (widget.searchTitle != null)
                buildSearchContent(context),
              if (widget.searchTitle != null)
                SizedBox(height: 3),
              if (widget.bottom != null)
                widget.bottom,
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
        widget.subTitle, //"140 Opportunities in your area today  ",
        style: theme.textTheme.bodyText1,
      ),
    );
  }

  Widget buildSearchContent(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xffeff4f6),
        ),
        child: TextField(
          decoration: InputDecoration(
            hintStyle: theme.textTheme.bodyText2,
            hintText: widget.searchTitle, //'Search Opportunities',
            suffixIcon: SvgPicture.asset(
              'packages/local_people_core/assets/images/search-pink.svg',
              fit: BoxFit.scaleDown,
              //clipBehavior: Clip.hardEdge,
              //height: 24,
              //width: 24,
            ),
            // suffixIcon: Icon(
            //     Icons.search,
            //   color: Color(0xffff6361),
            // ),
            // suffix: FittedBox (
            //   clipBehavior: Clip.hardEdge,
            //   child: SvgPicture.asset(
            //     'packages/local_people_core/assets/images/search-pink.svg',
            //     fit: BoxFit.cover,
            //     height: 28,
            //     width: 28,
            //   ),
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
    if (widget.showFilter == true) {
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
                widget.title,
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
                  elevation: 1,
                  hint: Text("Filter by"),
                  //dropdownColor: Color.fromRGBO(96, 106, 129, 1.0),
                  items: widget.filterItems.map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value, style: theme.bodyText1),
                    );
                  }).toList(),
                  value: widget.filterValue,
                  onChanged: (newValue) {
                    if (widget.onFilterValueChanged != null) {
                      widget.onFilterValueChanged(newValue);
                    }
                  },
                  // selectedItemBuilder: (BuildContext context) {
                  //   return widget.filterItems.map ((String item) {
                  //     return Container(
                  //       color: Color.fromRGBO(96, 106, 129, 1.0),
                  //         child: Text(item, style: theme.bodyText1),
                  //     );
                  //   }).toList();
                  // },
                ),
              ),
            ),
          ),
        ],
      );
    } else if (widget.subTitle != null) {
      return Container(
        padding: EdgeInsets.only(left: 12),
        child: Text(
          widget.subTitle != null ? widget.subTitle : '',
          textAlign: TextAlign.left,
          style: theme.headline6,
        ),
        //color: Colors.yellow,
      );
    } else {
      return Container(
        padding: EdgeInsets.only(left: 12),
        child: Text(
          widget.title,
          textAlign: TextAlign.left,
          style: theme.headline6,
        ),
        //color: Colors.yellow,
      );
    }
  }

  @override
  Size get preferredSize => widget.appBarPreferredSize;
}
