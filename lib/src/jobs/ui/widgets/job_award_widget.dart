import 'package:flutter/material.dart';
import '../../domain/entities/job.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_people_core/profile.dart';
import 'package:local_people_core/core.dart';

class JobAwardWidget extends StatefulWidget {
  final String clientName;
  final String traderName;
  JobAwardWidget({
    Key key,
    @required this.clientName,
    @required this.traderName,
  }) : super(key: key);

  @override
  _JobAwardWidgetState createState() => _JobAwardWidgetState();
}

class _JobAwardWidgetState extends State<JobAwardWidget> {
  final TextEditingController _messageTextController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20),
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
                    'Are you sure you want to award [Insert job name] to [insert trader name]?',
                    textAlign: TextAlign.left,
                    style: theme.textTheme.caption,
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
                  child: TextField (
                    autofocus: true,
                    controller: _messageTextController,
                    keyboardType: TextInputType.multiline,
                    minLines: 5,//Normal textInputField will be displayed
                    maxLines: 9,// when user presses enter it will adapt to it
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: InputBorder.none,
                      hintText: 'Would you like to add a message?',
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
                    textInputAction: TextInputAction.done,
                  ),
                ),
                ),
              ),
          ],
        ),
        SizedBox(height: 10),
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
                    DialogService _dialogService = sl<DialogService>();
                    JobAwardResponse response = JobAwardResponse(
                      status: JobAwardStatus.JOB_AWARD,
                      optionalMessage: _messageTextController.text,
                    );
                    _dialogService.jobAwardDialogComplete(response);
                  },
                  child: Text(
                    'Award Job',
                    style: theme.textTheme.button
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),);
  }
}
