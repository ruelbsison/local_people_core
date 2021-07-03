import 'package:flutter/material.dart';

import '../widgets/posted_by_widget.dart';
import '../../domain/entities/job.dart';
import '../widgets/job_view_widget.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/quote.dart';

class JobBidScreen extends StatefulWidget {
  JobBidScreen({
    Key key,
    @required this.job,
    this.appBarPreferredSize = const Size.fromHeight(180.0)
  }) : super(key: key);

  final Job job;
  final Size appBarPreferredSize;

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
    // _controller.addListener(() {
    //   setState(() {
    //     if (_controller.index == 1) {
    //       context
    //           .read<MessageBloc>()
    //           .add(LoadJobMessagesEvent(jobId: widget.job.id));
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

  Widget buildAppBar() {
    final theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    final appType = AppConfig.of(context).appType;
    return LocalPeopleAppBarWidget(
      title: widget.job.title != null ? widget.job.title : widget.job.description,
      startrDateTime: widget.job.date,
      //packageSvgAssetIcon: 'packages/local_people_core/assets/images/package-grey.svg',
      packageSvgAssetIcon: ((widget.job.date != null
          && (widget.job.date.difference(DateTime.now())).inDays > 0)
          ? 'packages/local_people_core/assets/images/package-green.svg'
          : 'packages/local_people_core/assets/images/package-orange.svg'),
      leadingText: (appType == AppType.TRADER
          ? LocalPeopleLocalizations.of(context).menuTitleOpportunities
          : LocalPeopleLocalizations.of(context).menuTitleYourJobs),
      bottom: TabBar(
        controller: _controller,
        //unselectedLabelColor: Color.fromRGBO(239, 244, 246, 1), //theme.primaryColor,
        unselectedLabelColor: Color.fromRGBO(87, 106, 129, 1), //theme.primaryColor,
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
    ); //
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
              //color: Color.fromRGBO(255, 255, 255, 1),
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  JobViewWidget(job: widget.job),
                  SizedBox(height: 10.0),
                  //PostedByWidget(profile: widget.profile),
                  PostedByWidget(clientId: widget.job.clientId),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
          QuoteBodyWidget(job:  widget.job,),
        ],
      ),
    );
  }
}
