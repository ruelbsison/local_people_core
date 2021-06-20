import 'package:flutter/material.dart';
import '../../domain/entities/job.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_people_core/quote.dart';
import 'package:local_people_core/core.dart';

class JobCancelWidget extends StatefulWidget {
  final Job job;

  JobCancelWidget({
    Key key,
    @required this.job,
  }) : super(key: key);

  @override
  _JobCancelWidgetState createState() => _JobCancelWidgetState();
}

class _JobCancelWidgetState extends State<JobCancelWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
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
                    'Are you sure you want to cancel this job?  Cancelling a job could mean the loss of your deposit (if cancelled with in XX) - Please check our terms and conditions for full details.',
                    textAlign: TextAlign.left,
                    style: theme.textTheme.caption,
                    maxLines: 4,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
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
                    'Add a message?',
                    textAlign: TextAlign.left,
                    style: theme.textTheme.caption,
                  ),
                ),
              ),
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
                      onPressed: () {},
                      child: Text(
                        'Cancel Job',
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