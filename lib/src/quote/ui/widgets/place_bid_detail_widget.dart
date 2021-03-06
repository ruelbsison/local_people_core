import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_people_core/jobs.dart';
import 'package:local_people_core/quote.dart';
import 'package:local_people_core/core.dart';
import 'dart:async';
import 'package:after_layout/after_layout.dart';

typedef OnDibDetailsSubmitted = void Function(double, double, double, double);
typedef OnGetTimeslot = DateTime Function();

class PlaceBidDetailWidget extends StatefulWidget {
  PlaceBidDetailWidget({
    Key key,
    this.job,
    this.pageController,
    this.onDibDetailsSubmitted,
    this.onGetTimeslot,
  }) : super(key: key);

  final PageController pageController;
  final OnDibDetailsSubmitted onDibDetailsSubmitted;
  final OnGetTimeslot onGetTimeslot;
  final Job job;
  Quote quote = Quote();
  DateTime selectedDate = DateTime.now();

  @override
  _PlaceBidDetailWidgetState createState() => _PlaceBidDetailWidgetState();
}

class _PlaceBidDetailWidgetState extends State<PlaceBidDetailWidget> with AfterLayoutMixin<PlaceBidDetailWidget> {
  final TextEditingController _labourTextController =
  TextEditingController();
  final TextEditingController _materialsCostTextController =
  TextEditingController();
  final TextEditingController _totalCostTextController =
      TextEditingController();
  final TextEditingController _depositRequiredDayTextController =
  TextEditingController();
  final TextEditingController _dateRequiredMonthTextController =
  TextEditingController();
  final TextEditingController _dateRequiredYearTextController =
  TextEditingController();
  final TextEditingController _deliveryDateTextController =
  TextEditingController();

  FocusNode _labourNodeLocation = new FocusNode();
  FocusNode _materialNodeLocation = new FocusNode();
  FocusNode _depositRequiredNodeLocation = new FocusNode();
  FocusNode _dateRequiredDayNodeLocation = new FocusNode();
  FocusNode _dateRequiredMothNodeLocation = new FocusNode();
  FocusNode _dateRequiredYearNodeLocation = new FocusNode();

  @override
  void afterFirstLayout(BuildContext context) {
    if (widget.pageController.page == 1.0) {
      if (_labourTextController.text == null ||
          _labourTextController.text.isEmpty == true)
        _labourNodeLocation.requestFocus();
      else if (_materialsCostTextController.text == null ||
          _materialsCostTextController.text.isEmpty == true)
        _materialNodeLocation.requestFocus();
      else if (_depositRequiredDayTextController.text == null ||
          _depositRequiredDayTextController.text.isEmpty == true)
        _depositRequiredNodeLocation.requestFocus();
    }
  }

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime picked = await showDatePicker(
  //       context: context,
  //       initialDate: widget.selectedDate,
  //       firstDate: DateTime(DateTime.now().year, DateTime.now().month),
  //       lastDate: DateTime(DateTime.now().year + 1));
  //   if (picked != null && picked != widget.selectedDate)
  //     setState(() {
  //       widget.selectedDate = picked;
  //       _dateRequiredDayTextController.text = (widget.selectedDate.day.toString().length == 1 ? '0' : '') + widget.selectedDate.day.toString();
  //       _dateRequiredMonthTextController.text = (widget.selectedDate.month.toString().length == 1 ? '0' : '') + widget.selectedDate.month.toString();
  //       _dateRequiredYearTextController.text = widget.selectedDate.year.toString();
  //     });
  // }

  @override
  void initState() {
    super.initState();

    widget.pageController.addListener(() async {
      if (widget.pageController.page == 1.0) {
        if (widget.onGetTimeslot != null) {
          await Future<void>.delayed(const Duration(seconds: 1));
          DateTime deliveryDate = widget.onGetTimeslot();
          if (deliveryDate != null) {
            _deliveryDateTextController.text =
                DateFormatUtil.getFormattedDateWithDateTime(deliveryDate);
          }
        }
        if (_labourTextController.text == null ||
            _labourTextController.text.isEmpty == true)
          _labourNodeLocation.requestFocus();
        else if (_materialsCostTextController.text == null ||
            _materialsCostTextController.text.isEmpty == true)
          _materialNodeLocation.requestFocus();
        else if (_depositRequiredDayTextController.text == null ||
            _depositRequiredDayTextController.text.isEmpty == true)
          _depositRequiredNodeLocation.requestFocus();
      }
    });

    //_labourTextController.text = '0.0';
    //_materialsCostTextController.text = '0.0';
    //_totalCostTextController.text = '0.0';
    // _labourNodeLocation.addListener(() {
    //   if (!_labourNodeLocation.hasFocus) {
    //     FocusScope.of(context).requestFocus(_materialNodeLocation);
    //   }
    // });
    // _materialNodeLocation.addListener(() {
    //   if (!_materialNodeLocation.hasFocus) {
    //     FocusScope.of(context).requestFocus(_depositRequiredNodeLocation);
    //   }
    // });
    // _depositRequiredNodeLocation.addListener(() {
    //   if (!_depositRequiredNodeLocation.hasFocus) {
    //     FocusScope.of(context).requestFocus(_dateRequiredDayNodeLocation);
    //   }
    // });
    // _dateRequiredDayNodeLocation.addListener(() {
    //   if (_dateRequiredDayNodeLocation.hasFocus) {
    //     _selectDate(context);
    //   }
    // });
    // _dateRequiredMothNodeLocation.addListener(() {
    //   if (_dateRequiredMothNodeLocation.hasFocus) {
    //     _selectDate(context);
    //   }
    // });
    // _dateRequiredYearNodeLocation.addListener(() {
    //   if (_dateRequiredYearNodeLocation.hasFocus) {
    //     _selectDate(context);
    //   }
    // });
  }

  @override
  void dispose() {
    _labourTextController.dispose();
    _materialsCostTextController.dispose();
    _totalCostTextController.dispose();
    _depositRequiredDayTextController.dispose();
    _dateRequiredMonthTextController.dispose();
    _dateRequiredYearTextController.dispose();

    _labourNodeLocation.dispose();
    _materialNodeLocation.dispose();
    _depositRequiredNodeLocation.dispose();
    _dateRequiredDayNodeLocation.dispose();
    _dateRequiredMothNodeLocation.dispose();
    _dateRequiredYearNodeLocation.dispose();
    _deliveryDateTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
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
                        'Labor',
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
                        focusNode: _labourNodeLocation,
                        controller: _labourTextController,
                        decoration: InputDecoration(
                          labelText: '?? Amount',
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
                        onSubmitted: (val) {
                          widget.quote.labour = val;
                          setState(() {
                            //_totalCostTextController.clear();
                            double materialCosts =
                                double.tryParse(_materialsCostTextController.text);
                            double laborCosts =
                                double.tryParse(_labourTextController.text);
                            if (materialCosts != null && laborCosts != null) {
                              _totalCostTextController.text = '?? ' +
                                  (materialCosts + laborCosts).toString();
                            } else if (materialCosts != null) {
                              _totalCostTextController.text =
                                  '??' + (materialCosts).toString();
                            } else if (laborCosts != null) {
                              _totalCostTextController.text =
                                  '??' + (laborCosts).toString();
                            } else {
                              _totalCostTextController.text = '?? 0.0';
                            }
                            _materialNodeLocation.requestFocus();
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
                        'Materials',
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
                        focusNode: _materialNodeLocation,
                        controller: _materialsCostTextController,
                        // decoration: new InputDecoration.collapsed(
                        //   hintText: '?? Amount',
                        // ),
                        decoration: InputDecoration(
                          labelText: '?? Amount',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          // border: InputBorder.none,
                          // focusedBorder: InputBorder.none,
                          // enabledBorder: InputBorder.none,
                          // errorBorder: InputBorder.none,
                          // disabledBorder: InputBorder.none,
                          // contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                        ),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (val) {
                          widget.quote.materials = val;
                          setState(() {
                            //_totalCostTextController.clear();
                            double materialCosts =
                            double.tryParse(_materialsCostTextController.text);
                            double laborCosts =
                            double.tryParse(_labourTextController.text);
                            if (materialCosts != null && laborCosts != null) {
                              _totalCostTextController.text = '?? ' +
                                  (materialCosts + laborCosts).toString();
                            } else if (materialCosts != null) {
                              _totalCostTextController.text =
                                  '??' + (materialCosts).toString();
                            } else if (laborCosts != null) {
                              _totalCostTextController.text =
                                  '??' + (laborCosts).toString();
                            } else {
                              _totalCostTextController.text = '?? 0.0';
                            }
                            _depositRequiredNodeLocation.requestFocus();
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
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Total',
                        textAlign: TextAlign.left,
                        style: theme.textTheme.bodyText1,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Card(
                        child: TextField(
                          readOnly: true,
                          textAlign: TextAlign.right,
                          controller: _totalCostTextController,
                          style: theme.textTheme.bodyText1,
                          decoration: InputDecoration(
                            labelText: '?? XXX',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            hasFloatingPlaceholder: false,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (val) {},
                        ),
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
                        'Deposit Required',
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
                        focusNode: _depositRequiredNodeLocation,
                        controller: _depositRequiredDayTextController,
                        decoration: InputDecoration(
                          fillColor: Color.fromRGBO(170, 186, 205, 1),
                          labelText: '?? Amount',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
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
                        'Delivery Date',
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
                        readOnly: true,
                        style: theme.textTheme.bodyText2,
                        controller: _deliveryDateTextController,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          labelText: 'Delivery Date',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        keyboardType: TextInputType.datetime,
                        textInputAction: TextInputAction.done,
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
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(left: 12.0, right: 12.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (widget.pageController != null && widget.pageController.hasClients) {
                          widget.pageController.animateToPage(
                            0,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: Text(
                        'Back',
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
                        double dLabour = double.tryParse(_labourTextController.text);
                        if (dLabour == null) {
                          _labourNodeLocation.requestFocus();
                          return;
                        }
                        double dMaterials = double.tryParse(_materialsCostTextController.text);
                        if (dMaterials == null) {
                          _materialNodeLocation.requestFocus();
                          return;
                        }

                        print(_totalCostTextController.text.replaceAll('??', '').replaceAll(' ', ''));
                        double dTotal = double.tryParse(_totalCostTextController.text.replaceAll('??', '').replaceAll(' ', ''));
                        if (dTotal == null) {
                          return;
                        }
                        double dDeposit = double.tryParse(_depositRequiredDayTextController.text);
                        if (dDeposit == null) {
                          _depositRequiredNodeLocation.requestFocus();
                          return;
                        }

                        if (widget.onDibDetailsSubmitted != null) {
                          widget.onDibDetailsSubmitted(dLabour, dMaterials, dTotal, dDeposit);
                        }
                      },
                      child: Text(
                        'Send',
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
