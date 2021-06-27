import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/job_form_bloc.dart';
import '../../domain/entities/job.dart';

class PostActionsWidget extends StatefulWidget {
  PostActionsWidget({
    Key key,
    @required this.job,
  }) : super(key: key);

  final Job job;

  @override
  _PostActionsWidgetState createState() => _PostActionsWidgetState();
}

class _PostActionsWidgetState extends State<PostActionsWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(239, 244, 246, 1), width: 2),
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white),
        child: Flex(
          direction: Axis.horizontal,
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(left: 12.0, right: 12.0),
                child: ElevatedButton(
                  onPressed: () => _saveJob(context),
                  child: Text(
                    LocalPeopleLocalizations.of(context).btnTitleSave,
                    style: theme.textTheme.button.copyWith(color: Colors.white),
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
                  onPressed: () => _postJob(context),
                  child: Text(
                    LocalPeopleLocalizations.of(context).btnTitlePost,
                    style: theme.textTheme.button.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  void _saveJob(BuildContext context) {
    Navigator.of(context).popUntil(ModalRoute.withName('/'));
  }

  void _postJob(BuildContext context) {
    BlocProvider.of<JobFormBloc>(context)
        .add((JobFormPostEvent(job: widget.job)));
    //Navigator.of(context).popUntil(ModalRoute.withName('/'));
  }
}