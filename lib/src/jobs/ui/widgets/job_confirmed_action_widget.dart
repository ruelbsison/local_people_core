import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/quote.dart';

typedef OnJobChange = void Function(Quote);
typedef OnJobCencel = void Function(Quote);

class JobConfirmedActionWidget extends StatefulWidget {
  final Quote quote;
  JobConfirmedActionWidget({
    Key key,
    @required this.quote,
    this.onJobChange,
    this.onJobCencel,
  }) : super(key: key);

  final OnJobChange onJobChange;
  final OnJobCencel onJobCencel;

  @override
  _JobConfirmedActionWidgetState createState() => _JobConfirmedActionWidgetState();
}

class _JobConfirmedActionWidgetState extends State<JobConfirmedActionWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      // color: Colors.white,
      padding: EdgeInsets.all(12.0),
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
          SizedBox(height: 10.0),
          Container(
            color: Colors.white,
            child: Flex(
                direction: Axis.horizontal,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(
                      LocalPeopleLocalizations.of(context).titleJobConfirmed,
                      textAlign: TextAlign.left,
                      style: theme.textTheme.bodyText1,
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
                    //padding:
                    //EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Align (
                      alignment: Alignment.centerLeft,
                      child: Text(
                        LocalPeopleLocalizations.of(context).titleStart,
                        textAlign: TextAlign.left,
                        style: theme.textTheme.bodyText2,
                      ),
                    )
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    //padding:
                    //EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        widget.quote.deliveryDate != null
                            ? DateFormatUtil.getFormattedDateWithDateTime(widget.quote.deliveryDate)
                            : '',
                        textAlign: TextAlign.right,
                        style: theme.textTheme.bodyText1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5.0),
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
                    //padding:
                    //EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Align (
                        alignment: Alignment.centerLeft,
                        child: Text(
                          LocalPeopleLocalizations.of(context).titleDuration,
                          textAlign: TextAlign.left,
                          style: theme.textTheme.bodyText2,
                        ),
                      )
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    //padding:
                    //EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        widget.quote.dureationRequired != null
                            ? widget.quote.dureationRequired.toString()
                            + (widget.quote.dureationRequired > 1 ? " hours" : " hour")
                            : '',
                        textAlign: TextAlign.right,
                        style: theme.textTheme.bodyText1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5.0),
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
                    //padding:
                    //EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Align (
                        alignment: Alignment.centerLeft,
                        child: Text(
                          LocalPeopleLocalizations.of(context).titlePlaceBid,
                          textAlign: TextAlign.left,
                          style: theme.textTheme.bodyText2,
                        ),
                      )
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    //padding:
                    //EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '£' + (widget.quote.totalCost != null
                            ? widget.quote.totalCost.toString()
                            : ''),
                        textAlign: TextAlign.right,
                        style: theme.textTheme.bodyText1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5.0),
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
                    //padding:
                    //EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Align (
                        alignment: Alignment.centerLeft,
                        child: Text(
                          LocalPeopleLocalizations.of(context).titleDepositRequired,
                          textAlign: TextAlign.left,
                          style: theme.textTheme.bodyText2,
                        ),
                      )
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    //padding:
                    //EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '£' + (widget.quote.depositRequired != null
                            ? widget.quote.depositRequired.toString()
                            : ''),
                        textAlign: TextAlign.right,
                        style: theme.textTheme.bodyText1,
                      ),
                    ),
                  ),
                ),
              ],
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
                      //padding:
                      //EdgeInsets.only(left: 12.0, right: 12.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(87, 106, 129, 1),
                          onPrimary: Color.fromRGBO(170, 186, 205, 1),
                        ),
                        onPressed: () {
                          if (widget.onJobChange != null)
                            widget.onJobChange(widget.quote);
                        },
                        child: Text(
                          LocalPeopleLocalizations.of(context)
                              .btnTitleEditJob,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.button.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.0),
                  Expanded(
                    flex: 1,
                    child: Container(
                      //padding:
                      //EdgeInsets.only(left: 12.0, right: 12.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(87, 106, 129, 1),
                          onPrimary: Color.fromRGBO(170, 186, 205, 1),
                        ),
                        onPressed: () {
                          if (widget.onJobCencel != null)
                            widget.onJobCencel(widget.quote);
                        },
                        child: Text(
                          LocalPeopleLocalizations.of(context)
                              .btnTitleCancelJob,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.button.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ),
          //SizedBox(height: 10.0),
        ],
      ),
    );
  }
}