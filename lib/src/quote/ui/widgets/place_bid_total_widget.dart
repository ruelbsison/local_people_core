import 'package:flutter/material.dart';
import 'package:overlay_dialog/overlay_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlaceBidTotallWidget extends StatefulWidget {
  PlaceBidTotallWidget({
    Key key,
  }) : super(key: key);

  @override
  _PlaceBidTotallWidgetState createState() => _PlaceBidTotallWidgetState();
}

class _PlaceBidTotallWidgetState extends State<PlaceBidTotallWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
      Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            color: Color.fromRGBO(239, 244, 246, 1),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Place Bid',
                      textAlign: TextAlign.left,
                      style: theme.textTheme.bodyText1,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Card(
                    //color: Color.fromRGBO(239, 244, 246, 1),
                    //padding: EdgeInsets.only(right: 10),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        padding: EdgeInsets.all(2.0),
                        icon: SvgPicture.asset(
                          'packages/local_people_core/assets/images/minus.svg',
                          height: 24,
                          width: 24,
                        ),
                        iconSize: 24,
                        onPressed: () => DialogHelper().hide(context),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 1.0,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Color.fromRGBO(186, 207, 216, 1),
                ),
              ),
            ),
          ),
        ],
      ),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flex(
            direction: Axis.horizontal,
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(left: 12.0, right: 12.0),
                  child: ElevatedButton(
                    onPressed: () => {},
                    child: Text(
                      'Save',
                      style: theme.textTheme.button.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(left: 12.0, right: 12.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(255, 99, 95, 1),
                      onPrimary: Color.fromRGBO(170, 186, 205, 1),
                    ),
                    onPressed: () => {},
                    child: Text(
                      'Next',
                      style: theme.textTheme.button.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
    );
  }
}
