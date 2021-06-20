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
  }) : super(key: key);

  final int traderId;
  List<Job> jobs;
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

  @override
  void initState() {
    super.initState();
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
      //Future
      //    .delayed(Duration(seconds: 5))
      //    .then((_) => _dialogService.successfulStatusDialogComplete());
      Navigator.of(context).pop();
      await _dialogService.showSuccessfulStatusDialog(message: 'Sent Successfully!');
      Navigator.of(context).pop();
      _dialogService.requestQuoteDialogComplete();
    } else {
      //Future
      //    .delayed(Duration(seconds: 5))
      //    .then((_) => _dialogService.errorStatusDialogComplete());
      await _dialogService.showErrorStatusDialog(message: 'Send Failed!');
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    context.read<JobBloc>().add(LoadJobs());
    DialogService _dialogService = sl<DialogService>();
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
      child: BlocBuilder<JobBloc, JobState>(
        builder: (context, state) {
          if (state is JobLoaded) {
            widget.jobs = state.jobs;
            if (selectedJob == null && widget.jobs != null && widget.jobs.length > 0)
              selectedJob = widget.jobs[0];
            widget.sugesstions =
                List.generate(widget.jobs.length, (index) => widget.jobs[index].title);
            return buildBody(context);
          } else if (state is JobNotLoaded) {
            return ErrorWidget('Error $state');
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    ),
    );

  }

  @override
  Widget buildBody(BuildContext context) {
    DialogService _dialogService = sl<DialogService>();
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.only(left: 12.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Job',
              textAlign: TextAlign.left,
              style: theme.textTheme.subtitle1,
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: EdgeInsets.only(left: 12.0, right: 12.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<Job>(
                hint: Text("Select Job"),
                value: selectedJob,
                focusNode: _focusNodeSelectJob,
                onChanged: (Job Value) {
                  //setState(() {
                  selectedJob = Value;
                  //});
                },
                items: widget.jobs.map((Job job) {
                  return DropdownMenuItem<Job>(
                    value: job,
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget> [
                          Text(
                            //job.id.toString(),
                            //(job.location != null && job.location.name != null ? job.location.name :
                            job.title != null
                                ? job.title
                                : job.description, //),
                            //textAlign: TextAlign.right,
                            style: theme.textTheme.bodyText1,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            textWidthBasis: TextWidthBasis.parent,
                          ),
                        ]
                    ),
                  );
                }
                ).toList(),
              ),
            ),
          ),
        ),
        // SizedBox(height: 10),
        // Column(
        //   mainAxisSize: MainAxisSize.min,
        //   children: <Widget>[
        //     Container(
        //       height: 1.0,
        //       decoration: BoxDecoration(
        //         color: Colors.white,
        //         border: Border(
        //           bottom: BorderSide(
        //             color: Color.fromRGBO(186, 207, 216, 1),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.only(left: 12.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Message',
              textAlign: TextAlign.left,
              style: theme.textTheme.subtitle1,
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.only(left: 12.0),
          child: TextField(
            autofocus: true,
            autocorrect: true,
            controller: _messageController,
            focusNode: _focusNodeMessage,
            keyboardType: TextInputType.multiline,
            minLines: 5,//Normal textInputField will be displayed
            maxLines: 9,// when user presses enter it will adapt to it
            textCapitalization: TextCapitalization.sentences,
            style: theme.textTheme.bodyText1,
            decoration: InputDecoration(
              //labelText: 'Describe this package',
              floatingLabelBehavior: FloatingLabelBehavior.never,
              // enabledBorder: OutlineInputBorder(
              //   borderSide: BorderSide.none,
              // ),
              // border: OutlineInputBorder(
              //   borderSide: BorderSide.none,
              // ),
              // border: OutlineInputBorder(
              //     borderRadius: BorderRadius.circular(30),
              //     borderSide: BorderSide.none),
              border: InputBorder.none,
              hintText: 'Add your quote request message here.',
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
              enabledBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: Colors.grey.shade300, width: 2),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  topLeft: Radius.circular(5),
                ),
              ),
            ),
            onChanged: (value) {
              //this._keyword = value;
            },
            onSubmitted: (val) {

            },
            textInputAction: TextInputAction.done,
          ),
        ),
        SizedBox(height: 20),
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
                        if (_messageController.text.isEmpty) {
                          _focusNodeMessage.requestFocus();
                          return;
                        }
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
