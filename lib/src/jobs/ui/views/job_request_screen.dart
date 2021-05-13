import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';
import '../widgets/job_card.dart';
import 'package:local_people_core/jobs.dart';

class JobRequestScreen extends StatefulWidget {
  @override
  _JobRequestScreenState createState() => _JobRequestScreenState();
}

class _JobRequestScreenState extends State<JobRequestScreen>
    with TickerProviderStateMixin {
  TabController _controller;
  int _tab = 0;

  @override
  void initState() {
    super.initState();

    _controller =  TabController(length: 2, vsync: this);
  }

  //@override
  //bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBarWidget (
        appBarPreferredSize: Size.fromHeight(120.0),
        //automaticallyImplyLeading: false,
        //toolbarHeight: 120.0,
        //centerTitle: false,
        //titleSpacing: 0,
        // title: Text(
        //   LocalPeopleLocalizations.of(context).menuTitleOpportunities,
        //   textAlign: TextAlign.left,
        //   style: theme.textTheme.headline6,
        // ),
        subTitle: LocalPeopleLocalizations.of(context).menuTitleOpportunities,
        appBar: AppBar(),
        bottom: TabBar(
          controller: _controller,
          unselectedLabelColor: theme.primaryColor,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color.fromRGBO(239, 244, 246, 1)),
          tabs: [
            Tab(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "REQUESTED JOB",
                  style: theme.textTheme.bodyText2,
                ),
              ),
            ),
            Tab(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "OPPORTUNITIES",
                  style: theme.textTheme.bodyText2,
                ),
              ),
            ),
          ],
        ),
      ),
      body: buildBody(context),
    );
  }

  AppBar buildAppBar() {

  }

  Widget buildBody(BuildContext context) {
    final theme = Theme.of(context);
    return TabBarView(
      controller: _controller,
      children: <Widget>[
        ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: demeJobs.length,
          itemBuilder: (context, index) =>
              JobCard(job: demeJobs[index]),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: demeJobs.length,
          itemBuilder: (context, index) =>
              JobCard(job: demeJobs[index]),
        ),
      ],
    );
  }
}
