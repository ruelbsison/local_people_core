import 'package:flutter/material.dart';
import 'package:local_people_core/jobs.dart';
import 'package:overlay_dialog/overlay_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_people_core/quote.dart';
import 'package:local_people_core/core.dart';

class QuoteRequestDetailWidget extends StatefulWidget {
  QuoteRequestDetailWidget({
    Key key,
    @required this.traderId,
    @required this.jobs,
  }) : super(key: key);

  final int traderId;
  final List<Job> jobs;
  List<String> sugesstions;

  @override
  _QuoteRequestDetailWidgetState createState() =>
      _QuoteRequestDetailWidgetState();
}

class _QuoteRequestDetailWidgetState extends State<QuoteRequestDetailWidget> {
  Job selectedJob;

  FocusNode _focusNodeSelectJob = new FocusNode();
  final TextEditingController _selectJobController =
      TextEditingController();

  FocusNode _focusNodeMessage = new FocusNode();
  final TextEditingController _messageController =
  TextEditingController();
  DialogService _dialogService = sl<DialogService>();

  @override
  void initState() {
    super.initState();

    widget.sugesstions =
        List.generate(widget.jobs.length, (index) => widget.jobs[index].title);
    //jobs
  }

  @override
  void dispose() {
    _focusNodeSelectJob.dispose();
    _selectJobController.dispose();

    _focusNodeMessage.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _showProgressDialog(DialogService _dialogService) async {
    StatusDialogResponse dialogResult = await _dialogService.showStatusDialog(
      title: 'Request Quote',
      message: 'Sending...',
    );
    if (dialogResult.status == StatusDialogStatus.SUCCESSFUL) {
      _dialogService.requestQuoteDialogComplete();
      Future
          .delayed(Duration(seconds: 5))
          .then((_) => _dialogService.successfulStatusDialogComplete());
      await _dialogService.showSuccessfulStatusDialog(message: 'Sent Successfully!');
    } else {
      Future
          .delayed(Duration(seconds: 5))
          .then((_) => _dialogService.errorStatusDialogComplete());
      await _dialogService.showErrorStatusDialog(message: 'Send Failed!');
    }
  }

  @override
  Widget build(BuildContext context) {
    // QuoteRequestAddEvent
    return BlocProvider.value(
      value: BlocProvider.of<QuoteRequestBloc>(context),
      child: BlocListener<QuoteRequestBloc, QuoteRequestState>(
        listener: (context, state) {
          if (state is QuoteRequestAdded) {
            _dialogService.statusDialogComplete(
                StatusDialogResponse(
                    status: StatusDialogStatus.SUCCESSFUL
                )
            );
          } else if (state is QuoteRequestAddFailed){
            _dialogService.statusDialogComplete(
                StatusDialogResponse(
                    status: StatusDialogStatus.FAILED
                )
            );
          } else if (state is QuoteRequestAdding){
            _showProgressDialog(_dialogService);
          }
        },
        child: buildBody(context),
      ),
    );

  }

  @override
  Widget buildBody(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
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
                        'Job',
                        textAlign: TextAlign.left,
                        style: theme.textTheme.bodyText1,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Card (
                    //padding: EdgeInsets.only(right: 10),
                    child: StatefulBuilder(builder:
                        (BuildContext context, StateSetter dropDownState) {
                      return DropdownButton<Job>(
                        hint: Text("Select Job"),
                        value: selectedJob,
                        focusNode: _focusNodeSelectJob,
                        onChanged: (Job Value) {
                          setState(() {
                            selectedJob = Value;
                          });
                        },
                        items: widget.jobs.map((Job job) {
                          return DropdownMenuItem<Job>(
                            value: job,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  //job.id.toString(),
                                  (job.location != null && job.location.name != null ? job.location.name :
                                  job.title != null
                                      ? job.title
                                      : job.description),
                                  style: theme.textTheme.bodyText2,
                                  overflow: TextOverflow.ellipsis,
                                  textWidthBasis: TextWidthBasis.parent,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    }),
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
        SizedBox(height: 10),
        Expanded(
          flex: 1,
          child: Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Message',
                textAlign: TextAlign.left,
                style: theme.textTheme.bodyText1,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Card (
            //padding: EdgeInsets.only(right: 10),
            child: Align(
              alignment: Alignment.centerRight,
              child: TextField(
                expands: true,
                minLines: null,
                maxLines: null,
                focusNode: _focusNodeMessage,
                controller: _messageController,
                textCapitalization: TextCapitalization.sentences,
                style: theme.textTheme.bodyText2,
                textAlignVertical: TextAlignVertical.top,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  labelText: 'Add your quote request message here.',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
              ),
            ),
          ),
        ),
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
                      onPressed: () => _dialogService.requestQuoteDialogComplete(),
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
                        QuoteRequest quoteRequest = QuoteRequest(
                          jobId: selectedJob.id,
                          clientId: selectedJob.clientId,
                          traderId: widget.traderId,
                          message: _messageController.text,
                        );
                        BlocProvider.of<QuoteRequestBloc>(context).add(
                            QuoteRequestAddEvent(
                                quoteRequest: quoteRequest
                            )
                        );
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
        SizedBox(height: 10),
      ],
    );
  }
}
