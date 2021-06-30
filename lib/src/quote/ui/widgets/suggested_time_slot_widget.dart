import 'package:flutter/material.dart';
import 'package:overlay_dialog/overlay_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_people_core/quote.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/schedule.dart';

import 'package:intl/intl.dart';
import 'dart:async';
import 'package:after_layout/after_layout.dart';

typedef OnSuggestedTimeSlotSubmitted = void Function(int, DateTime);

class SuggestedTimeSlotWidget extends StatefulWidget {
  static final uuid = Uuid();
  Quote quote;
  final OnSuggestedTimeSlotSubmitted onSuggestedTimeSlotSubmitted;
 final PageController pageController;
  final ScheduleBloc scheduleBloc;

  SuggestedTimeSlotWidget({
    Key key,
    @required this.pageController,
    @required this.scheduleBloc,
    this.onSuggestedTimeSlotSubmitted,
  }) : super(key: key);

  @override
  _SuggestedTimeSlotWidgetState createState() =>
      _SuggestedTimeSlotWidgetState();
}

class _SuggestedTimeSlotWidgetState extends State<SuggestedTimeSlotWidget> with AfterLayoutMixin<SuggestedTimeSlotWidget> {
  List<bool> isSelected = [false, false, false];

  final TextEditingController _durationController = TextEditingController();
  FocusNode _focusNodeDuration = new FocusNode();
  bool onLoad = true;
  Timeslot selectedTimeslot;
  Timeslot firstLoadedTimeslot;

  final List<String> _durationFilterItem = [
    "1 hour",
    "2 hours",
    "3 hours",
    "4 hours",
    "5 hours",
    "6 hours",
    "7 hours",
    "8 hours",
    "9 hours",
    "10 hours",
    "11 hours",
    "12 hours",
    "13 hours",
    "14 hours",
    "15 hours",
    "16 hours",
    "17 hours",
    "18 hours",
    "19 hours",
    "20 hours",
    "21 hours",
    "22 hours",
    "23 hours",
    "24 hours",
  ];

  String durationValue;
  int duration;

  @override
  void initState() {
    _durationController.text = '1';
    duration = 1;
    durationValue = _durationFilterItem[0];

    widget.pageController.addListener(() {
      if (widget.pageController.page == 1.0) {
        if (selectedTimeslot == null) {
          selectedTimeslot = firstLoadedTimeslot;
        }

        if (widget.onSuggestedTimeSlotSubmitted != null) {
          widget.onSuggestedTimeSlotSubmitted(duration, selectedTimeslot.startDateTime);
        }
      }
    });


    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {


    if (onLoad == true || firstLoadedTimeslot == null) {
      widget.scheduleBloc.getTimeslots(interval: 1);
      onLoad = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
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
                    padding: EdgeInsets.only(left: 12.0),
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
                      child: SingleChildScrollView (
                        padding: EdgeInsets.only(right: 12),
                        //child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            hint: Text("Hours"),
                            focusColor: Color.fromRGBO(96, 106, 129, 1.0),
                            items: _durationFilterItem.map((String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value,
                                    style: theme.textTheme.bodyText2,),
                              );
                            }).toList(),
                            value: durationValue,
                            onChanged: (newValue) {
                              setState(() {
                                durationValue = newValue;

                                String tmo = newValue;
                                String val = tmo.replaceAll(' hours', '');
                                print('val: ' + val);
                                tmo = val;
                                print('newValue: ' + tmo);
                                val = tmo.replaceAll(' hour', '');
                                print('val: ' + val);
                                if (int.tryParse(val) != null) {
                                  duration = int.tryParse(val);
                                  print('duration: ' + duration.toString());
                                  widget.scheduleBloc.getTimeslots(interval: duration);
                                }
                              });
                            },
                          ),
                        //),
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
        SizedBox(height: 20),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.only(left: 12.0),
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
        SizedBox(height: 20),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Card (
                      child: getTimeslotsWidget(),
                  ),
                ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'View Calendar for akternate time slots.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.caption,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20),
        Column(
          mainAxisSize: MainAxisSize.max,
          //crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.start,
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
                      onPressed: () {
                          DialogService _dialogService = sl<DialogService>();
                          _dialogService.placeBidDialogComplete(null);
                          Navigator.of(context).pop();
                        },
                      child: Text(
                        'Cancel',
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
                      onPressed: () {
                        //BlocProvider.of<QuoteBloc>(context).add(QuoteAddEvent(quote: widget.quote));
                        //DialogHelper().hide(context);
                        //int duration = int.parse(_durationController.text);
                        if (duration == null) {
                          _focusNodeDuration.requestFocus();
                          return;
                        }
                        if (selectedTimeslot == null) {
                          return;
                        }

                        if (widget.onSuggestedTimeSlotSubmitted != null) {
                          widget.onSuggestedTimeSlotSubmitted(duration, selectedTimeslot.startDateTime);
                        }
                        if (widget.pageController != null && widget.pageController.hasClients) {
                          widget.pageController.animateToPage(
                            1,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
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
        SizedBox(height: 10),
      ],
    ),);
  }

  Widget getTimeslotsWidget() {
    /*The StreamBuilder widget,
    basically this widget will take stream of data (todos)
    and construct the UI (with state) based on the stream
    */

    return StreamBuilder(
      stream: widget.scheduleBloc.timeslots,
      builder: (BuildContext context, AsyncSnapshot<List<Timeslot>> timeslots) {
            //if (timeslots.connectionState != ConnectionState.none)
        return getTodoCardWidget(timeslots);
      },
    );
  }

  Widget getTodoCardWidget(AsyncSnapshot<List<Timeslot>> timeslots) {
    final theme = Theme.of(context);
    /*Since most of our operations are asynchronous
    at initial state of the operation there will be no stream
    so we need to handle it if this was the case
    by showing users a processing/loading indicator*/
    if (timeslots.hasData) {
      /*Also handles whenever there's stream
      but returned returned 0 records of Todo from DB.
      If that the case show user that you have empty Todos
      */
      return timeslots.data.length != 0
          ? ToggleButtons(
        direction: Axis.vertical,
        borderRadius: BorderRadius.circular(35.0),
        fillColor: Colors.white,
        borderColor: Color.fromRGBO(255, 99, 95, 1),
        borderWidth: 1.0,
        textStyle: theme.textTheme.bodyText1,
        onPressed: (int index) {
          setState(() {
            for (int buttonIndex = 0;
              buttonIndex < isSelected.length;
              buttonIndex++) {
                if (buttonIndex == index) {
                  isSelected[buttonIndex] = true;
                  selectedTimeslot = timeslots.data[index];
                } else {
                  isSelected[buttonIndex] = false;
                }
            }
          });
        },
        isSelected: isSelected,
        children: timeslots.data.map((Timeslot timeslot) {
          if (firstLoadedTimeslot == null)
            firstLoadedTimeslot = timeslot;
          return Padding (
            padding: EdgeInsets.all(6.0),
            child: Card (
              //tag: SuggestedTimeSlotWidget.uuid.v4(),
              child: Text(
                DateFormatUtil.getFormattedDateWithDateTime(timeslot.startDateTime),
                textAlign: TextAlign.left,
                style: theme.textTheme.bodyText1,
              ),
            ),
          );
        }).toList(),) : Container(
          child: Center(
            //this is used whenever there 0 Todo
            //in the data base
            child: Container(),
          ));
    } else {
      return LoadingWidget();
    }
  }

}
