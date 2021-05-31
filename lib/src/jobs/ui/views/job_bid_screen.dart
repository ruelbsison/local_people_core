import 'package:flutter/material.dart';

import '../widgets/posted_by_widget.dart';
import '../../domain/entities/job.dart';
import '../widgets/job_view_widget.dart';
import 'package:local_people_core/messages.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobBidScreen extends StatefulWidget {
  JobBidScreen({
    Key key,
    @required this.job,
  }) : super(key: key);

  final Job job;

  @override
  _JobBidScreenState createState() => _JobBidScreenState();
}

class _JobBidScreenState extends State<JobBidScreen>
    with TickerProviderStateMixin {
  TabController _controller;
  int _tab = 0;

  @override
  void initState() {
    super.initState();

    _controller = TabController(length: 2, vsync: this);
    _controller.addListener(() {
      setState(() {
        if (_controller.index == 1) {
          context
              .read<MessageBloc>()
              .add(LoadJobMessagesEvent(jobId: widget.job.id));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(context),
    );
  }

  AppBar buildAppBar() {
    final theme = Theme.of(context);
    return AppBar(
      /*leading: Text(
        LocalPeopleLocalizations.of(context).menuTitleOpportunities,
      ),*/
      toolbarHeight: 220.0,
      centerTitle: false,
      titleSpacing: 0,
      title: Container(
        padding: EdgeInsets.only(bottom: 12.0),
        child: Flex(
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
                    backgroundColor: Color.fromRGBO(255, 166, 0, 1),
                    radius: 15,
                    child: Center(
                        child: Image.asset(
                      'packages/local_people_core/assets/images/package-icon.png',
                      fit: BoxFit.contain,
                      height: 19,
                      width: 19,
                    )),
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
                    widget.job.title != null
                        ? widget.job.title
                        : widget.job.description,
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
                "JOB DETAILS",
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

  Widget buildBody(BuildContext context) {
    final theme = Theme.of(context);
    final appType = AppConfig.of(context).appType;
    return TabBarView(
      controller: _controller,
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(12.0),
            padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
            color: Color.fromRGBO(255, 255, 255, 1),
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                JobViewWidget(job: widget.job),
                SizedBox(height: 20.0),
                //PostedByWidget(profile: widget.profile),
                PostedByWidget(clientId: widget.job.clientId),
                SizedBox(height: 50.0),
              ],
            ),
          ),
        ),
        BlocProvider(
          create: (context) => MessageBloc(
            messageRepository: RepositoryProvider.of<MessageRepository>(context),
            appType: appType,
            authLocalDataSource: sl<AuthLocalDataSource>(),
          ),
          child: BlocBuilder<MessageBloc, MessageState>(
            builder: (context, state) {
              if (state is MessageInitial) {
                return LoadingWidget();
              } else if (state is JobMessageLoading) {
                return LoadingWidget();
              } else if (state is LoadJobMessageFailed) {
                return ErrorWidget('Unhandle State $state');
              } else if (state is JobMessageLoaded) {
                return MessageBody(
                  messages: state.messages,
                );
              }
              return ErrorWidget('Unhandle State $state');
            },
          ),
        ),
      ],
    );
  }
}
