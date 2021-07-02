import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_people_core/core.dart';

class BidPendingDepositActionWidget extends StatefulWidget {
  final DateTime createdAt;
  BidPendingDepositActionWidget({
    Key key,
    @required this.createdAt,
      }) : super(key: key);

  @override
  _BidPendingDepositActionWidgetState createState() => _BidPendingDepositActionWidgetState();
}

class _BidPendingDepositActionWidgetState extends State<BidPendingDepositActionWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      // color: Colors.white,
      // padding: EdgeInsets.all(12.0),
      // margin: EdgeInsets.only(top: 12.0),
      decoration: BoxDecoration(
          border: Border.all(color: Color.fromRGBO(239, 244, 246, 1), width: 2),
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white),
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20.0),
          Container(
            color: Colors.white,
            child: Flex(
                direction: Axis.vertical,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 7,
                    child: Text(
                      LocalPeopleLocalizations.of(context).titleBidPlaced + ' '
                          + (widget.createdAt != null
                          ? DateFormatUtil.getDateTimeDiff(
                          DateTime.now(), widget.createdAt)
                          : ''),
                      textAlign: TextAlign.left,
                      style: theme.textTheme.bodyText1,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'view',
                      textAlign: TextAlign.right,
                      style: theme.textTheme.subtitle2,
                    ),
                  ),
                ]
            ),
          ),
          SizedBox(height: 20.0),
          Container(
              color: Colors.white,
              child: Flex(
                direction: Axis.horizontal,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding:
                      EdgeInsets.only(left: 12.0, right: 12.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(87, 106, 129, 1),
                          onPrimary: Color.fromRGBO(170, 186, 205, 1),
                        ),
                        onPressed: () {;},
                        child: Text(
                          LocalPeopleLocalizations.of(context)
                              .btnTitleJobAwarded,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.button.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding:
                      EdgeInsets.only(left: 12.0, right: 12.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Color.fromRGBO(170, 186, 205, 1),
                        ),
                        onPressed: () { },
                        child: Text(
                          LocalPeopleLocalizations.of(context)
                              .btnTitleAwaitingDeposit,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.button.copyWith(color: Color.fromRGBO(87, 106, 129, 1)),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          //SizedBox(height: 10.0),
        ],
      ),
    );
  }
}