import 'package:flutter/material.dart';
import '../../domain/entities/job.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_people_core/quote.dart';
import 'package:local_people_core/core.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:intl/intl.dart';
//import 'package:flutter_time_date_picker/flutter_time_date_picker.dart';

class JobChangeWidget extends StatefulWidget {
  final DateTime startDateTime;
  final int durationInHours;
  final double price;

  JobChangeWidget({
    Key key,
    @required this.startDateTime,
    @required this.durationInHours,
    @required this.price,
  }) : super(key: key);

  @override
  _JobChangeWidgetState createState() => _JobChangeWidgetState();
}

class _JobChangeWidgetState extends State<JobChangeWidget> {
  final TextEditingController _controllerTime = TextEditingController();
  final TextEditingController _controllerDate = TextEditingController();
  //final TextEditingController _controllerDuration = TextEditingController();
  final TextEditingController _controllerPrice = TextEditingController();

  FocusNode _focusNodeTime = new FocusNode();
  FocusNode _focusNodeDate = new FocusNode();
  FocusNode _focusNodeDuration = new FocusNode();
  FocusNode _focusNodePrice = new FocusNode();

  String timeValue;
  String dateValue;
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

  double priceValue;

  DateTime startDate;
  DateTime startTime;

  //DateTimePickerTheme dateTimePickerTheme;

  @override
  void initState() {
    super.initState();

    //_controllerTime.text = DateFormat('hh:mm a').format(widget.startDateTime);
    _controllerTime.text = DateFormat('HH:mm').format(widget.startDateTime);
    _controllerDate.text = DateFormat('d MMMM yyyy').format(widget.startDateTime);
    duration = 1;
    durationValue = _durationFilterItem[0];
    //_controllerDuration.text = durationValue;
        //+ (widget.durationInHours > 1
        //  ? ' hours' : ' hour');
    _controllerPrice.text = widget.price.toString();
  }

  @override
  void dispose() {
    _controllerTime.dispose();
    _controllerDate.dispose();
    //_controllerDuration.dispose();
    _controllerPrice.dispose();

    _focusNodeTime.dispose();
    _focusNodeDate.dispose();
    _focusNodeDuration.dispose();
    _focusNodePrice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // dateTimePickerTheme = DateTimePickerTheme(
    // backgroundColor: theme.backgroundColor,
    // cancelTextStyle: theme.textTheme.bodyText1,
    // confirmTextStyle: theme.textTheme.bodyText1,
    // );
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Time',
                        textAlign: TextAlign.left,
                        style: theme.textTheme.bodyText2,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Card(
                    //padding: EdgeInsets.only(right: 10),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: DateTimePicker(
                        type: DateTimePickerType.time,
                        //dateMask: 'hh:mm a',
                        controller: _controllerTime,
                        focusNode: _focusNodeTime,
                        //initialValue: _initialValue,
                        //icon: Icon(Icons.access_time),
                        //timeLabelText: "Time",
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        use24HourFormat: true,
                        textAlign: TextAlign.right,
                        //locale: Locale('en', 'US'),
                        onChanged: (val) {
                          setState(() {
                            timeValue = val;
                          });
                          print(val);
                        },
                        onSaved: (val) {
                          print('Time.onSaved: ' + val);
                        },
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Date',
                        textAlign: TextAlign.left,
                        style: theme.textTheme.bodyText2,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Card(
                    //padding: EdgeInsets.only(right: 10),
                    child: Align(
                      alignment: Alignment.centerRight,
                      // child: DatePickerWidget(
                      //   minDateTime: DateTime.now(),
                      //   maxDateTime: DateTime.now().add(const Duration(days: 365)),
                      //   initialDateTime: widget.startDateTime,
                      //   dateFormat: 'dd MMMM yyyy',
                      //   pickerTheme: dateTimePickerTheme,
                      //   // pickerTheme: DateTimePickerTheme(
                      //   //   backgroundColor: const Color(0xFFb2dfdb),
                      //   //   cancelTextStyle: const TextStyle(color: Colors.white),
                      //   //   confirmTextStyle: TextStyle(color: Colors.black),
                      //   //   itemTextStyle: TextStyle(color: Colors.deepOrange),
                      //   //   pickerHeight: 300.0,
                      //   //   titleHeight: 24.0,
                      //   //   itemHeight: 30.0,
                      //   // ),
                      //   onChange: (dateTime, selectedIndex) {
                      //     setState(() {
                      //       startDate = dateTime;
                      //     });
                      //   },
                      // ),
                      child: DateTimePicker(
                        type: DateTimePickerType.date,
                        dateMask: 'd MMMM yyyy',
                        controller: _controllerDate,
                        focusNode: _focusNodeDate,
                        //initialValue: _initialValue,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                        //icon: Icon(Icons.event),
                        textAlign: TextAlign.right,
                        // decoration: InputDecoration(
                        //   floatingLabelBehavior: FloatingLabelBehavior.never,
                        //   enabledBorder: OutlineInputBorder(
                        //     borderSide: BorderSide.none,
                        //   ),
                        //   border: OutlineInputBorder(
                        //     borderSide: BorderSide.none,
                        //   ),
                        // ),
                        //dateLabelText: 'Date',
                        //locale: Locale('en', 'US'),
                        onChanged: (val) {
                          setState(() {
                            dateValue = val;
                          });
                          print(val);
                        },
                        onSaved: (val) {
                          print('Date.onSaved: ' + val);
                        },
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
                        'Duration',
                        textAlign: TextAlign.left,
                        style: theme.textTheme.bodyText2,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Card(
                    //padding: EdgeInsets.only(right: 10),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        focusNode: _focusNodeDuration,
                        hint: Text("Hours"),
                        focusColor: Color.fromRGBO(96, 106, 129, 1.0),
                        items: _durationFilterItem.map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value,
                              textAlign: TextAlign.right,
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
                            duration = int.tryParse(val);
                            if (duration != null) {
                              duration = int.tryParse(val);
                              print('duration: ' + duration.toString());
                            }
                          });
                        },
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
                        'Price',
                        textAlign: TextAlign.left,
                        style: theme.textTheme.bodyText2,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Card(
                    //padding: EdgeInsets.only(right: 10),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextField(
                        style: theme.textTheme.bodyText2,
                        textAlign: TextAlign.right,
                        focusNode: _focusNodePrice,
                        controller: _controllerPrice,
                        decoration: InputDecoration(
                          labelText: '£ Amount',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onChanged: (val) {
                          priceValue = double.tryParse(val);
                        },
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
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flex(
              direction: Axis.horizontal,
              children: <Widget>[
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
                        DateTime startDateTime;
                        try {
                          startDateTime = startDate;
                          //DateTime date = DateFormat('d MMMM yyyy').parse(dateValue);
                          //DateTime time = DateFormat('HH:mm').parse(timeValue);
                          //startDateTime = DateFormat('d MMMM yyyy HH:mm').parse(dateValue + ' ' + timeValue);
                        } catch(fex) {
                          print(fex.toString());
                        }
                        if (startDateTime == null)
                          return;

                        if (duration == null) {
                          _focusNodeDuration.requestFocus();
                          return;
                        }

                        priceValue = double.tryParse(_controllerPrice.text);
                        if (priceValue == null) {
                          _focusNodePrice.requestFocus();
                          return;
                        }

                        JobChangeResponse jobChangeResponse = JobChangeResponse(
                          startDateTime: startDateTime,
                          durationInHours: duration,
                          price: priceValue,
                        );
                        DialogService _dialogService = sl<DialogService>();
                        _dialogService.jobChangeDialogComplete(jobChangeResponse);
                      },
                      child: Text(
                        'Send Change Request',
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
    ),);
  }
}