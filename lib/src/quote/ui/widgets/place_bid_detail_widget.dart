import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_people_core/jobs.dart';
import 'package:local_people_core/quote.dart';
import 'package:local_people_core/core.dart';

class PlaceBidDetailWidget extends StatefulWidget {
  PlaceBidDetailWidget({
    Key key,
    this.job,
  }) : super(key: key);

  final Job job;
  Quote quote = Quote();
  DateTime selectedDate = DateTime.now();

  @override
  _PlaceBidDetailWidgetState createState() => _PlaceBidDetailWidgetState();
}

class _PlaceBidDetailWidgetState extends State<PlaceBidDetailWidget> {
  final TextEditingController _labourTextController =
  TextEditingController();
  final TextEditingController _materialsCostTextController =
  TextEditingController();
  final TextEditingController _totalCostTextController =
      TextEditingController();
  final TextEditingController _dateRequiredDayTextController =
  TextEditingController();
  final TextEditingController _dateRequiredMonthTextController =
  TextEditingController();
  final TextEditingController _dateRequiredYearTextController =
  TextEditingController();

  FocusNode _labourNodeLocation = new FocusNode();
  FocusNode _materialNodeLocation = new FocusNode();
  FocusNode _depositRequiredNodeLocation = new FocusNode();
  FocusNode _dateRequiredDayNodeLocation = new FocusNode();
  FocusNode _dateRequiredMothNodeLocation = new FocusNode();
  FocusNode _dateRequiredYearNodeLocation = new FocusNode();

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

    //_labourTextController.text = '0.0';
    //_materialsCostTextController.text = '0.0';
    //_totalCostTextController.text = '0.0';
    _labourNodeLocation.addListener(() {
      if (!_labourNodeLocation.hasFocus) {
        FocusScope.of(context).requestFocus(_materialNodeLocation);
      }
    });
    _materialNodeLocation.addListener(() {
      if (!_materialNodeLocation.hasFocus) {
        FocusScope.of(context).requestFocus(_depositRequiredNodeLocation);
      }
    });
    _depositRequiredNodeLocation.addListener(() {
      if (!_depositRequiredNodeLocation.hasFocus) {
        FocusScope.of(context).requestFocus(_dateRequiredDayNodeLocation);
      }
    });
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
    _dateRequiredDayTextController.dispose();
    _dateRequiredMonthTextController.dispose();
    _dateRequiredYearTextController.dispose();

    _labourNodeLocation.dispose();
    _materialNodeLocation.dispose();
    _depositRequiredNodeLocation.dispose();
    _dateRequiredDayNodeLocation.dispose();
    _dateRequiredMothNodeLocation.dispose();
    _dateRequiredYearNodeLocation.dispose();
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
        // Column(
        //   mainAxisSize: MainAxisSize.min,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: <Widget>[
        //     Container(
        //       color: Color.fromRGBO(239, 244, 246, 1),
        //       child: Row(
        //         mainAxisSize: MainAxisSize.max,
        //         children: <Widget>[
        //           Expanded(
        //             flex: 3,
        //             child: Container(
        //               padding: EdgeInsets.only(left: 12.0),
        //               child: Align(
        //                 alignment: Alignment.centerLeft,
        //                 child: Text(
        //                   'Place Bid',
        //                   textAlign: TextAlign.left,
        //                   style: theme.textTheme.bodyText1,
        //                 ),
        //               ),
        //             ),
        //           ),
        //           Expanded(
        //             flex: 1,
        //             child: Card(
        //               color: Color.fromRGBO(239, 244, 246, 1),
        //               //padding: EdgeInsets.only(right: 10),
        //               child: Align(
        //                 alignment: Alignment.centerRight,
        //                 child: IconButton(
        //                   padding: EdgeInsets.all(2.0),
        //                   icon: SvgPicture.asset(
        //                     'packages/local_people_core/assets/images/minus.svg',
        //                     height: 24,
        //                     width: 24,
        //                   ),
        //                   iconSize: 24,
        //                   onPressed: () {
        //                     DialogService _dialogService = sl<DialogService>();
        //                     _dialogService.placeBidDialogComplete();
        //                   },
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
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
                        focusNode: _labourNodeLocation,
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
                        onSubmitted: (val) {
                          widget.quote.labour = val;
                          setState(() {
                            _totalCostTextController.clear();
                            double materialCosts =
                                double.tryParse(_labourTextController.text);
                            double laborCosts =
                                double.tryParse(_materialsCostTextController.text);
                            if (materialCosts != null && laborCosts != null) {
                              _totalCostTextController.text = '£' +
                                  (materialCosts + laborCosts).toString();
                            } else if (materialCosts != null) {
                              _totalCostTextController.text =
                                  '£' + (materialCosts).toString();
                            } else if (laborCosts != null) {
                              _totalCostTextController.text =
                                  '£' + (laborCosts).toString();
                            } else {
                              _totalCostTextController.text = '£ 0.0';
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
                        focusNode: _materialNodeLocation,
                        controller: _materialsCostTextController,
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
                        onSubmitted: (val) {
                          widget.quote.materials = val;
                          setState(() {
                            _totalCostTextController.clear();
                            double materialCosts =
                            double.tryParse(_labourTextController.text);
                            double laborCosts =
                            double.tryParse(_materialsCostTextController.text);
                            if (materialCosts != null && laborCosts != null) {
                              _totalCostTextController.text = '£' +
                                  (materialCosts + laborCosts).toString();
                            } else if (materialCosts != null) {
                              _totalCostTextController.text =
                                  '£' + (materialCosts).toString();
                            } else if (laborCosts != null) {
                              _totalCostTextController.text =
                                  '£' + (laborCosts).toString();
                            } else {
                              _totalCostTextController.text = '£ 0.0';
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
                          controller: _totalCostTextController,
                          style: theme.textTheme.bodyText1,
                          decoration: InputDecoration(
                            labelText: '£ XXX',
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
                        focusNode: _depositRequiredNodeLocation,
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
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        /*Column(
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
                        'Date Required',
                        textAlign: TextAlign.left,
                        style: theme.textTheme.bodyText2,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Card (
                      //padding: EdgeInsets.only(right: 10),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextField(
                          style: theme.textTheme.bodyText2,
                          controller: _dateRequiredDayTextController,
                          focusNode: _dateRequiredDayNodeLocation,
                          decoration: InputDecoration(
                            labelText: 'DD',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ),
                    Card (
                      //padding: EdgeInsets.only(right: 10),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextField(
                          style: theme.textTheme.bodyText2,
                          controller: _dateRequiredMonthTextController,
                          decoration: InputDecoration(
                            labelText: 'MM',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ),
                    Card (
                      //padding: EdgeInsets.only(right: 10),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextField(
                          style: theme.textTheme.bodyText2,
                          controller: _dateRequiredYearTextController,
                          decoration: InputDecoration(
                            labelText: 'YYYY',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ),
                  ]
                  ),
                ),
              ],
            ),
          ],
        ),*/
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
                        widget.quote.jobId = widget.job.id;
                        //widget.quote.deliveryTime = DateTime.parse(formattedString);
                        BlocProvider.of<QuoteBloc>(context)
                            .add((QuoteAddEvent(quote: widget.quote)));
                        //DialogHelper().hide(context);
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
