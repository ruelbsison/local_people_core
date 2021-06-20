import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/job_bloc.dart';
import '../blocs/job_event.dart';
import '../blocs/job_state.dart';


class JobBlocDialog extends StatelessWidget {
  final JobBloc jobBloc;
  final JobEvent startEvent;
  final JobEvent taskEvent;

  JobBlocDialog({
    @required this.jobBloc,
    @required this.startEvent,
    @required this.taskEvent,
  }) : assert(jobBloc != null);

  @override
  Widget build(BuildContext context) {
    // _newEventBloc = NewEventBloc(jobBloc: jobBloc);
    return BlocConsumer<JobBloc, JobState>(
        bloc: jobBloc,
        listenWhen: (previous, current) {
          // return true/false to determine whether or not
          // to invoke listener with state
          return false;
        },
        listener: (context, state) {
          // do stuff here based on BlocA's state
        },
        buildWhen: (previous, current) {
          // return true/false to determine whether or not
          // to rebuild the widget with state
          return false;
        },
        builder: (context, state) {
          // return widget here based on BlocA's state
          return Container();
        });

    return BlocBuilder<JobBloc, JobState>(
      bloc: jobBloc,
      builder: (BuildContext context, JobState state) {},
    );
  }
}
