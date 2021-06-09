import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/jobs.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PackageCard extends StatefulWidget {
  const PackageCard({
    Key key,
    @required this.package,
  }) : super(key: key);

  final Package package;

  @override
  _PackageCardState createState() => _PackageCardState();
}

class _PackageCardState extends State<PackageCard> {
  @override
  Widget build(BuildContext context) {
    List<Widget> columnChildren = <Widget>[];
    columnChildren.add(SizedBox(height: 10));

    if (widget.package == null) {
      columnChildren.add(Container());
    } else {
      columnChildren.add(build_package_header(context));
    }
    if (widget.package.optionType != PackageOptionType.ADD_NEW) {
      columnChildren.add(SizedBox(height: 10));
      columnChildren.add(build_package_details(context));
    }
    if (widget.package.optionType == PackageOptionType.VIEW_ONLY) {
      columnChildren.add(SizedBox(height: 10));
      columnChildren.add(build_package_booking_action(context));
    }

    columnChildren.add(SizedBox(height: 20));
    return Container(
      color: Color(0xfff5f5f5),
      //padding: const EdgeInsets.only(left: 15, right: 18, top: 34, bottom: 56, ),
      child: Flex (
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: columnChildren,
      ),
    );
  }

  Widget build_package_details(BuildContext context) {
    final theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
      List<Widget> columnChildren = <Widget>[
        Row (
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container (
              padding: EdgeInsets.only(left: 10),
              width: size.width - 60,
              child: Align (
                alignment: Alignment.center,
                child: Text(
                  widget.package.description != null ? widget.package.description : '',
                  maxLines: 16,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row (
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Duration:',
                style: theme.textTheme.bodyText2,
              ),
            ),
            Container(
              //width: size.width - 60,
              child: Text(
                widget.package.durationInHours != null ? widget.package.durationInHours.toString() + ' Hours' : '',
                style: theme.textTheme.bodyText1,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row (
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Cost:',
                style: theme.textTheme.bodyText2,
              ),
            ),
            Container(
              //width: size.width - 60,
              //padding: EdgeInsets.only(left: 10),
              child: Text(
                widget.package.cost != null ? '\$' + widget.package.cost.toString() : '',
                style: theme.textTheme.bodyText1,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
      ];

    return Container(
      color: Color(0xfff5f5f5),
      //padding: const EdgeInsets.only(left: 15, right: 18, top: 34, bottom: 56, ),
      child: Flex (
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: columnChildren,
      ),
    );
  }

  Widget build_package_header(BuildContext context) {
     final theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    AppType appType = AppConfig.of(context).appType;
    List<Widget> columnChildren = <Widget>[];
    columnChildren.add(Expanded(
      flex: 1,
      child: Container(
        //padding: EdgeInsets.only(left: 10),
        child: CircleAvatar(
          backgroundColor: Color.fromRGBO(170,186,205,1),
          radius: 15,
          child: SvgPicture.asset(
            'packages/local_people_core/assets/images/package-grey.svg',
            height: 37,
            width: 37,
          ),
        ),
      ),
    ),);

    columnChildren.add(Expanded(
      flex: 3,
      child: Container(
        child: Align  (
          alignment: Alignment.centerLeft,
          child: Text(
            widget.package.name,
            textAlign: TextAlign.left,
            style: theme.textTheme.bodyText1,
          ),
        ),
      ),
    ),);

    if (widget.package.optionType != PackageOptionType.VIEW_ONLY) {
      columnChildren.add(Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.only(right: 10),
          child: Align  (
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: SvgPicture.asset(
                ((widget.package.optionType == PackageOptionType.ADD_DEFAULT ||
                    widget.package.optionType == PackageOptionType.ADD_NEW) ?
                'packages/local_people_core/assets/images/plus.svg' :
                'packages/local_people_core/assets/images/minus.svg'),
                height: 24,
                width: 24,
              ),
              iconSize: 24,
              onPressed: () {
                if (widget.package.optionType == PackageOptionType.REMOVE) {
                  BlocProvider.of<PackageBloc>(context)
                      .add(PackageDeleteEvent(id: widget.package.id));
                } else {

                }
              },
            ),
          ),
        ),
      ),);
    }

    return  Row(
      mainAxisSize: MainAxisSize.max,
      children: columnChildren,
    );
  }

  Widget build_package_booking_action(BuildContext context) {
    final theme = Theme.of(context);
    return Row (
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container (
          padding: EdgeInsets.only(left: 10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color.fromRGBO(255, 99, 95, 1),
              onPrimary: Color.fromRGBO(170, 186, 205, 1),
            ),
            onPressed: () => {},
            child: Text(
              'Book Package',
              textAlign: TextAlign.center,
              style: theme.textTheme.button.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
