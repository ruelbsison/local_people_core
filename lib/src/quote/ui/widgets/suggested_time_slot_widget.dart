import 'package:flutter/material.dart';
import 'package:overlay_dialog/overlay_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uuid/uuid.dart';

class SuggestedTimeSlotWidget extends StatefulWidget {
  static final uuid = Uuid();

  SuggestedTimeSlotWidget({
    Key key,
  }) : super(key: key);

  @override
  _SuggestedTimeSlotWidgetState createState() =>
      _SuggestedTimeSlotWidgetState();
}

class _SuggestedTimeSlotWidgetState extends State<SuggestedTimeSlotWidget> {
  List<bool> isSelected = [false, false, false];
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Duration Required',
                        textAlign: TextAlign.left,
                        style: theme.textTheme.bodyText2,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Card (
                    //padding: EdgeInsets.only(right: 10),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextField(
                        style: theme.textTheme.bodyText2,
                        decoration: InputDecoration(
                          labelText: 'hours',
                        ),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
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
            ),
          ],
        ),
        SizedBox(height: 10),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Suggested Time Slots',
                        textAlign: TextAlign.left,
                        style: theme.textTheme.bodyText1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 10),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Card(
                    child: ToggleButtons(
                      direction: Axis.vertical,
                      borderRadius: BorderRadius.circular(35.0),
                      fillColor: Colors.white,
                      borderColor: Color.fromRGBO(255, 99, 95, 1),
                      borderWidth: 1.0,
                      textStyle: theme.textTheme.bodyText1,
                      children: <Widget>[
                        Padding (
                          padding: EdgeInsets.all(12.0),
                          child: Card (
                            //tag: SuggestedTimeSlotWidget.uuid.v4(),
                            child: Text(
                              '2.00pm 7th July 2021',
                              textAlign: TextAlign.left,
                              style: theme.textTheme.bodyText1,
                            ),
                          ),
                        ),
                        Padding (
                          padding: EdgeInsets.all(12.0),
                          child: Card (
                            //tag: SuggestedTimeSlotWidget.uuid.v4(),
                            child: Text(
                              '4.00pm 7th July 2021',
                              textAlign: TextAlign.left,
                              style: theme.textTheme.bodyText1,
                            ),
                          ),
                        ),
                        Padding (
                          padding: EdgeInsets.all(12.0),
                          child: Card (
                            //tag: SuggestedTimeSlotWidget.uuid.v4(),
                            child: Text(
                              '6.00pm 7th July 2021',
                              textAlign: TextAlign.left,
                              style: theme.textTheme.bodyText1,
                            ),
                          ),
                        ),
                      ],
                      onPressed: (int index) {
                        setState(() {
                          for (int buttonIndex = 0;
                          buttonIndex < isSelected.length;
                          buttonIndex++) {
                            if (buttonIndex == index) {
                              isSelected[buttonIndex] = true;
                            } else {
                              isSelected[buttonIndex] = false;
                            }
                          }
                        });
                      },
                      isSelected: isSelected,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 10),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'View Calendar for akternate time slots.',
                        textAlign: TextAlign.left,
                        style: theme.textTheme.bodyText2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                        style: theme.textTheme.button
                            .copyWith(color: Colors.white),
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
                        style: theme.textTheme.button
                            .copyWith(color: Colors.white),
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
