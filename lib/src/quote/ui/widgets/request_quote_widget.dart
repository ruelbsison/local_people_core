import 'package:flutter/material.dart';
import 'quote_request_detail_widget.dart';
import 'package:local_people_core/jobs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestQuoteWidget extends StatefulWidget {
  RequestQuoteWidget({
    Key key,
    @required this.traderId,
  }) : super(key: key);

  final int traderId;
  @override
  _RequestQuoteWidgetState createState() => _RequestQuoteWidgetState();
}

class _RequestQuoteWidgetState extends State<RequestQuoteWidget> {
  PageController _controller;

  @override
  Widget build(BuildContext context) {
    context.read<JobBloc>().add(LoadJobs());
    return Container(
      //color: Colors.white,
      width: 345,
      height: 429,
      // margin: EdgeInsets.only(left: 12, right: 12),
      // //padding: EdgeInsets.all(10),
      // decoration: BoxDecoration(
      //     border: Border.all(color: Color.fromRGBO(239, 244, 246, 1), width: 2),
      //     borderRadius: BorderRadius.circular(8.0),
      //     color: Colors.white),
        child: BlocProvider.value(
          value: context.read<JobBloc>(),
          child: BlocBuilder<JobBloc, JobState>(
            builder: (context, state) {
              if (state is JobLoaded) {
                return QuoteRequestDetailWidget(jobs: state.jobs, traderId: widget.traderId,);
              } else if (state is JobNotLoaded) {
                return ErrorWidget('Error $state');
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
    );
  }

  Widget buildSuggestedTimeSlot(BuildContext context) {}

  @override
  void initState() {
    super.initState();

    _controller = PageController(
      initialPage: 0,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
