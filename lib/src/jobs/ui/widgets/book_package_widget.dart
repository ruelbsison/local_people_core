import 'package:flutter/material.dart';
import '../../domain/entities/booking.dart';
import '../../domain/entities/package.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_people_core/core.dart';
import 'package:intl/intl.dart';

class BookPackageWidget extends StatefulWidget {
  final Package package;
  final String traderName;
  BookPackageWidget({
    @required this.package,
    @required this.traderName,
  });

  @override
  _BookPackageWidgetState createState() => _BookPackageWidgetState();
}

class _BookPackageWidgetState extends State<BookPackageWidget> {
  final TextEditingController _durationTextController = TextEditingController();
  final TextEditingController _earliestnTextController = TextEditingController();
  FocusNode _focusNodeDuration = new FocusNode();
  FocusNode _focusNodeEarlist = new FocusNode();
  DateTime earliest;

  @override
  void initState() {
    super.initState();

    DateTime tomorrow = DateTime.now().add(Duration(days: 1));
    earliest = DateTime.parse(DateFormat("yyyy-MM-dd'T'09:00:00.ms'Z'").format(tomorrow));

    _earliestnTextController.text = DateFormatUtil.getFormattedDateWithDateTime(earliest);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 20),
        Column(
          mainAxisSize: MainAxisSize.max,
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
                        'Duration Required',
                        textAlign: TextAlign.left,
                        style: theme.textTheme.bodyText1,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextField(
                        autofocus: true,
                        style: theme.textTheme.bodyText2,
                        //controller: _nameTextController,
                        //focusNode: _focusNodeName,
                        decoration: InputDecoration(
                          labelText: 'Hours',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: InputBorder.none,
                          hintText: 'Hours',
                          hintStyle: theme.textTheme.bodyText2,
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.grey.shade300, width: 2),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5),
                              topLeft: Radius.circular(5),
                            ),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (val) {
                          //_focusNodeEarlist.requestFocus();
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
                        'Earliest Availability',
                        textAlign: TextAlign.left,
                        style: theme.textTheme.bodyText1,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextField(
                        readOnly: true,
                        style: theme.textTheme.bodyText2,
                        controller: _earliestnTextController,
                        focusNode: _focusNodeEarlist,
                        decoration: InputDecoration(
                          labelText: 'Earliest Availability',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          // border: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(30),
                          //     borderSide: BorderSide.none),
                          border: InputBorder.none,
                          hintText: 'Earliest Availability',
                          hintStyle: theme.textTheme.bodyText2,
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.grey.shade300, width: 2),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5),
                              topLeft: Radius.circular(5),
                            ),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          // enabledBorder: OutlineInputBorder(
                          //   borderSide:
                          //   BorderSide(color: Colors.grey.shade300, width: 2),
                          //   borderRadius: BorderRadius.only(
                          //     topRight: Radius.circular(5),
                          //     topLeft: Radius.circular(5),
                          //   ),
                          // ),
                        ),
                       // keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (val) {
                         // _focusNodeDesc.requestFocus();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.only(left: 12.0),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              'SEE ALTERNATE TIME SLOTS',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyText1,
            ),
          ),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.only(left: 12.0),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.only(left: 12.0, right: 12.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(255, 99, 95, 1),
                  onPrimary: Color.fromRGBO(170, 186, 205, 1),
                ),
                onPressed: () {
                  if (_durationTextController.text.isEmpty) {
                    _focusNodeDuration.requestFocus();
                    return;
                  }
                  Booking booking = Booking(
                    details: widget.package.description,
                    startTime: earliest,
                    jobId: -1,
                    traderId: widget.package.traderId,
                    //optionType: PackageOptionType.REMOVE,
                    entityStatus: EntityStatus.ENTIRY_STATUS_CREATING,
                  );
                  DialogService _dialogService = sl<DialogService>();
                  _dialogService.bookPackageDialogComplete(
                      BookPackageResponse(
                          booking: booking
                      )
                  );
                },
                child: Text(
                    'SEND BOOKING REQUEST',
                  style: theme.textTheme.button
                      .copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
