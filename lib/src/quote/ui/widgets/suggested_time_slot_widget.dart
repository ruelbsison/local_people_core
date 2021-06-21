import 'package:flutter/material.dart';
import 'package:overlay_dialog/overlay_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_people_core/quote.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/schedule.dart';
import 'package:intl/intl.dart';

class SuggestedTimeSlotWidget extends StatefulWidget {
  static final uuid = Uuid();
  Quote quote;

  SuggestedTimeSlotWidget({
    Key key,
  }) : super(key: key);

  @override
  _SuggestedTimeSlotWidgetState createState() =>
      _SuggestedTimeSlotWidgetState();
}

class _SuggestedTimeSlotWidgetState extends State<SuggestedTimeSlotWidget> {
  List<bool> isSelected = [false, false, false];
  final ScheduleBloc scheduleBloc = ScheduleBloc();
  final TextEditingController _durationController =
  TextEditingController();

  @override
  void initState() {
    _durationController.text = '1';
    scheduleBloc.getTimeslots(interval:int.parse(_durationController.text) );

    super.initState();
    //jobs
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
                  flex: 1,
                  child: Card (
                    //padding: EdgeInsets.only(right: 10),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextField(
                        autofocus: true,
                        style: theme.textTheme.bodyText2,
                        decoration: InputDecoration(
                          labelText: 'hours',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                        onSubmitted: (val) {
                          scheduleBloc.getTimeslots(interval: int.parse(val));
                        },
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
                      //padding: EdgeInsets.only(left: 12.0, right: 12.0),
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
                          _dialogService.placeBidDialogComplete();
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
                        BlocProvider.of<QuoteBloc>(context).add(QuoteAddEvent(quote: widget.quote));
                        DialogHelper().hide(context);
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
      stream: scheduleBloc.timeslots,
      builder: (BuildContext context, AsyncSnapshot<List<Timeslot>> timeslots) {
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
                } else {
                  isSelected[buttonIndex] = false;
                }
            }
          });
        },
        isSelected: isSelected,
        children: timeslots.data.map((Timeslot timeslot) {
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
      return Center(
        /*since most of our I/O operations are done
        outside the main thread asynchronously
        we may want to display a loading indicator
        to let the use know the app is currently
        processing*/
        child: LoadingWidget(),
      );
    }
  }
}
