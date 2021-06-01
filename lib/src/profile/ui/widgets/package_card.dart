import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';
import '../../domain/entities/package.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PackageCard extends StatelessWidget {
  const PackageCard({
    Key key,
    @required this.package,
    this.isAdd = false,
  }) : super(key: key);

  final Package package;
  final bool isAdd;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    AppType appType = AppConfig.of(context).appType;
    List<Widget> columnChildren = <Widget>[
      Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              child: CircleAvatar(
                backgroundColor: Color.fromRGBO(170,186,205,1),
                radius: 15,
                child: Align  (
                    alignment: Alignment.centerLeft,
                    child: SvgPicture.asset(
                      'packages/local_people_core/assets/images/package-icon.svg',
                      height: 37,
                      width: 36,
                    ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  //padding: EdgeInsets.only(left: 10),
                  //padding: EdgeInsets.only(left: 12, top: 40),
                  child: Text(
                    package.name,
                    textAlign: TextAlign.left,
                    style: theme.textTheme.bodyText1,
                  ),
                  //color: Colors.green,
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () {
                      //AppRouter.pushPage(context, ProfileScreen(profile: profile,));
                    },
                    child: Card(
                      elevation: 2,
                      //color: Color.fromRGBO(196, 196, 196, 1),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      child: SvgPicture.asset(
                        isAdd == true ? 'packages/local_people_core/assets/images/plus.svg' :  'packages/local_people_core/assets/images/minus.svg',
                        height: 25,
                        width: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
    ];


    if (isAdd == false) {
      List<Widget> columnChildren2 = <Widget>[
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
                    package.description != null ? package.description : '',
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
                    package.durationInHours != null ? package.durationInHours.toString() + ' Hours' : '',
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
                    package.cost != null ? '\$' + package.cost.toString() : '',
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
              Container (
                padding: EdgeInsets.only(left: 10),
                child: ElevatedButton(
                  onPressed: () => {},
                  child: Text(
                    'Book Package',
                    //LocalPeopleLocalizations.of(context)
                    //    .btnTitleCancel,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.button,
                  ),
                ),
              ),
            ],
          ),
        SizedBox(height: 20),
    ];
      columnChildren.addAll(columnChildren2);
    }

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
}
