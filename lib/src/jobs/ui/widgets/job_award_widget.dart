import 'package:flutter/material.dart';
import '../../domain/entities/job.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_people_core/profile.dart';
import 'package:local_people_core/core.dart';

class JobAwardWidget extends StatefulWidget {
  final Job job;
  final TraderProfile traderProfile;
  JobAwardWidget({
    Key key,
    @required this.job,
    @required this.traderProfile,
  }) : super(key: key);

  @override
  _JobAwardWidgetState createState() => _JobAwardWidgetState();
}

class _JobAwardWidgetState extends State<JobAwardWidget> {
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
                  child: TextField(
                    expands: true,
                    minLines: null,
                    maxLines: null,
                    //focusNode: _focusNodeMessage,
                    //controller: _messageController,
                    textCapitalization: TextCapitalization.sentences,
                    style: theme.textTheme.bodyText2,
                    decoration: InputDecoration(
                      labelText: 'Would you like to add a message?',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    keyboardType: TextInputType.text,
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
                  onPressed: () {},
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
