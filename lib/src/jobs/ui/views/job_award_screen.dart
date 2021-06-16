import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/auth.dart';
import 'package:local_people_core/messages.dart';
import 'package:local_people_core/quote.dart';

import '../widgets/posted_by_widget.dart';
import '../../domain/entities/job.dart';
import '../widgets/job_view_widget.dart';
import '../widgets/job_actions_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class JobAwardScreen extends StatefulWidget {
  JobAwardScreen({
    Key key,
    @required this.quote,
  }) : super(key: key);

  final Quote quote;

  @override
  _JobAwardScreenState createState() => _JobAwardScreenState();
}

class _JobAwardScreenState extends State<JobAwardScreen>
    with TickerProviderStateMixin {
  TabController _controller;
  int _tab = 0;

  @override
  void initState() {
    super.initState();

    _controller = TabController(length: 2, vsync: this);
    // _controller.addListener(() {
    //   setState(() {
    //     if (_controller.index == 1) {
    //       context
    //           .read<MessageBloc>()
    //           .add(LoadJobMessagesEvent(jobId: widget.quote.job.id));
    //     }
    //   });
    // });
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
                    //backgroundColor: Color.fromRGBO(255, 166, 0, 1),
                    radius: 15,
                    child: SvgPicture.asset(
                      'packages/local_people_core/assets/images/package-orange.svg',
                    ),
                    // child: Center(
                    //     child: Image.asset(
                    //   'packages/local_people_core/assets/images/package-icon.png',
                    //   fit: BoxFit.contain,
                    //   height: 19,
                    //   width: 19,
                    // )),
                  ),
                  Text(
                    // (widget.quote.job.minutesLeft / 60).toString() + ' hrs left',
                    widget.quote.job.minutesLeft.toString() + ' hrs left',
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
                    widget.quote.job.title != null
                        ? widget.quote.job.title
                        : widget.quote.job.description,
                    textAlign: TextAlign.left,
                    style: theme.textTheme.headline6,
                  ),
                  //),
                  //Expanded(
                  //  flex: 1,
                  //child: Text(
                  Text(
                    'Trader Name',
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
                "BID DETAILS",
                style: theme.textTheme.bodyText2,
              ),
            ),
          ),
          Tab(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "MESSAGES",
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
    return SafeArea(
      child: TabBarView(
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  JobViewWidget(job: widget.quote.job),
                  SizedBox(height: 20.0),
                  //PostedByWidget(profile: widget.profile),
                  PostedByWidget(clientId: widget.quote.job.clientId),
                  SizedBox(height: 10.0),
                  JobActionsWidget(job: widget.quote.job,),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
          BlocProvider(
            create: (context) => MessageBloc(
              messageRepository:
                  RepositoryProvider.of<MessageRepository>(context),
              appType: appType,
              authLocalDataSource: sl<AuthLocalDataSource>(),
            )..add(LoadJobMessagesEvent(jobId: widget.quote.job.id)),
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
                    messageBox: new MessageBox(
                      name: widget.quote.job.title,
                      jobId: widget.quote.job.id,
                      traderId: widget.quote.job.traderId,
                      clientId: widget.quote.job.clientId,
                    ),
                    messages: state.messages,
                  );
                }
                return ErrorWidget('Unhandle State $state');
              },
            ),
          ),
        ],
      ),
    );
  }
}
