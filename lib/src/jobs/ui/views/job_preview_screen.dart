import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'dart:async';
import 'dart:typed_data';
import '../widgets/posted_by_widget.dart';
import '../widgets/post_actions_widget.dart';
import '../../domain/entities/profile.dart';
import '../../domain/entities/job.dart';
import '../widgets/job_view_widget.dart';
import 'package:google_place/google_place.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:local_people_core/jobs.dart';
import '../blocs/job_form_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_people_core/core.dart';

class JobPreviewScreen extends StatefulWidget {
  JobPreviewScreen({
    Key key,
    @required this.job,
    //@required this.profile,
  }) : super(key: key);

  final Job job;
  //final Profile profile;

  @override
  _JobPreviewScreenState createState() =>
      _JobPreviewScreenState();
}

class _JobPreviewScreenState extends State<JobPreviewScreen>
with TickerProviderStateMixin {
  TabController _controller;
  int _tab = 0;

  void requestPermission() async {
    Map<Permission, PermissionStatus> statuses =
    await [Permission.location].request();
  }

  @override
  void initState() {
    super.initState();

    _controller = TabController(length: 2, vsync: this);

    requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: buildAppBar(context),
      appBar: buildAppBar(),
      //body: buildTabBody(context),
      //body: buildBody(context),
      body: BlocProvider.value(
        value: BlocProvider.of<JobFormBloc>(context),
        child: buildBody(),
      ),
    );

    //return buildBody(context);
  }

  AppBar buildAppBar() { //}BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      /*leading: Text(
        LocalPeopleLocalizations.of(context).menuTitleOpportunities,
      ),*/
      toolbarHeight: 220.0,
      centerTitle: false,
      titleSpacing: 0,
      title: Column (
        //padding: EdgeInsets.only(bottom: 12.0),
        //child: Flex(
        children: <Widget> [
          SizedBox(height: 60.0),
          Flex(
          direction: Axis.horizontal,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Flex(
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Color.fromRGBO(255,166,0,1),
                    radius: 15,
                    child: Center (
                        child: Image.asset(
                          'packages/local_people_core/assets/images/package-icon.png',
                          fit: BoxFit.contain,
                          height: 19,
                          width: 19,
                        )
                    ),
                  ),
                  Text(
                    // (widget.job.minutesLeft / 60).toString() + ' hrs left',
                    widget.job.minutesLeft.toString() + ' hrs left',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 63, 92, 1),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'RedHatDisplay'),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Flex(
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  //Expanded(
                  //  flex: 2,
                  //child: Text(
                  Text(
                    widget.job.title != null ? widget.job.title : widget.job.description,
                    textAlign: TextAlign.left,
                    style: theme.textTheme.headline6,
                  ),
                  //),
                  //Expanded(
                  //  flex: 1,
                  //child: Text(
                  Text(
                    'Client Name',
                    textAlign: TextAlign.left,
                    style: theme.textTheme.bodyText1,
                  ),
                  //),
                ],
              ),
            ),
          ],
        ),
      ]
      ),
      elevation: 0.0,
      bottom: TabBar(
        controller: _controller,
        //unselectedLabelColor: Color.fromRGBO(239, 244, 246, 1), //theme.primaryColor,
        indicatorSize: TabBarIndicatorSize.tab,
        //indicatorColor: Color.fromRGBO(239, 244, 246, 1),
        indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Color.fromRGBO(239, 244, 246, 1)),
        tabs: [
          Tab(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "DETAILS",
                style: theme.textTheme.bodyText2,
              ),
            ),
          ),
          Tab(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "BIDS",
                style: theme.textTheme.bodyText2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBody() { //BuildContext context) {
    return BlocListener<JobFormBloc, JobFormState>(
      listener: (context, state) {
        if (state is JobFormPostCompleted) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          showDialog<void>(
            context: context,
            builder: (_) => SuccessDialog(),
          );
        } else if (state is JobFormPosting) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Job Posting...')),
            );
        }
      },
      child: buildTabBody(context),
    );
  }

  Widget buildTabBody(BuildContext context) {
    return TabBarView(
      controller: _controller,
      children: <Widget>[
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              JobViewWidget(job: widget.job,),
              //SizedBox(height: 10.0),
              //PostedByWidget(profile: widget.profile),
              PostedByWidget(),
              //SizedBox(height: 10.0),
              //PostActionsWidget(),
              _jobPostActions(context),
              //SizedBox(height: 10.0),
            ],
          ),
        ),
        //MessageBody(),
        Container(),
      ],
    );
  }

  Widget _jobPostActions(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(12.0),
      //margin: EdgeInsets.all(12.0),
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Flex(
                direction: Axis.horizontal,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 7,
                    child: Text(
                      LocalPeopleLocalizations.of(context).menuTitlePostJob,
                      textAlign: TextAlign.left,
                      style: theme.textTheme.bodyText1,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      LocalPeopleLocalizations.of(context).titleDeleteJob,
                      textAlign: TextAlign.left,
                      style: theme.textTheme.subtitle2,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: CircleAvatar(
                      backgroundColor: Color(0xbbd0d9),
                      radius: 16,
                      child: Center (
                          child: Image.asset(
                            'packages/local_people_core/assets/images/delete-job-icon.png',
                            fit: BoxFit.contain,
                            height: 25,
                            width: 25,
                          )
                      ),
                    ),
                  ),
                ]
            ),
          ),
          SizedBox(height: 30.0),
          Container(
              color: Colors.white,
              child: Flex(
                direction: Axis.horizontal,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding:
                      EdgeInsets.only(left: 12.0, right: 12.0),
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).popUntil(ModalRoute.withName('/')),
                        child: Text(
                            LocalPeopleLocalizations.of(context)
                                .btnTitleSave),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding:
                      EdgeInsets.only(left: 12.0, right: 12.0),
                      child: ElevatedButton(
                        onPressed: () => context.read<JobFormBloc>().add(JobFormPostEvent(job: widget.job)),
                        child: Text(
                            LocalPeopleLocalizations.of(context)
                                .btnTitlePost),
                      ),
                    ),
                  ),
                ],
              )),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}

/*class JobCancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<JobBloc, JobState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.status.isValidated
              ? () => context.read<JobFormBloc>().add(JobFormSave())
              : null,
          child: Text(
            LocalPeopleLocalizations.of(context)
                .btnTitleCancel,
            style: theme.textTheme.button,
          ),
        );
      },
    );
  }
}

class JobPostButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<JobFormBloc, JobFormState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.status.isValidated
              ? () => context.read<JobFormBloc>().add(JobFormPost())
              : null,
          child: Text(
            LocalPeopleLocalizations.of(context).btnTitlePost,
            style: theme.textTheme.button,
          ),
        );
      },
    );
  }
}*/

class SuccessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const Icon(Icons.info),
                const Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Job Posted Successfully!',
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).popUntil(ModalRoute.withName('/')),
            ),
          ],
        ),
      ),
    );
  }
}
