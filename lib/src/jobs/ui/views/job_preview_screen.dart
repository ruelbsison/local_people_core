import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../widgets/posted_by_widget.dart';
import '../widgets/post_actions_widget.dart';
import '../../domain/entities/profile.dart';
import '../../domain/entities/job.dart';
import '../widgets/job_view_widget.dart';

class JobPreviewScreen extends StatefulWidget {
  JobPreviewScreen({
    Key key,
    @required this.job,
    @required this.profile,
  }) : super(key: key);

  final Job job;
  final Profile profile;

  @override
  _JobPreviewScreenState createState() =>
      _JobPreviewScreenState();
}

class _JobPreviewScreenState extends State<JobPreviewScreen>
    with TickerProviderStateMixin {
  TabController _controller;
  int _tab = 0;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(context),
    );

    //return buildBody(context);
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

  Widget buildBody(BuildContext context) {
    return TabBarView(
      controller: _controller,
      children: <Widget>[
        SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              JobViewWidget(job: widget.job),
              SizedBox(height: 20.0),
              PostedByWidget(profile: widget.profile),
              SizedBox(height: 50.0),
              PostActionsWidget(),
              SizedBox(height: 10.0),
            ],
          ),
        ),
        //MessageBody(),
        Container(),
      ],
    );
  }
    /*final theme = Theme.of(context);
    final levelIndicator = Container(
      child: Container(
        child: LinearProgressIndicator(
            backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
            //value: widget.job.budget.replaceAll(RegExp("^P "), '')),
            value: 200.0,
            valueColor: AlwaysStoppedAnimation(Colors.green)),
      ),
    );

    final coursePrice = Container(
      padding: const EdgeInsets.all(7.0),
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0)),
      child: new Text(
        widget.job.budget,
        style: TextStyle(color: Colors.white),
      ),
    );

    final topContentText = Flex(
      direction: Axis.horizontal,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 120.0),
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
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("drive-steering-wheel.jpg"),
                fit: BoxFit.cover,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    final bottomContent =  TabBarView(
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
                PostedByWidget(profile: widget.profile),
                SizedBox(height: 50.0),
                PostActionsWidget(),
                SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
        //MessageBody(),
        Container(),
      ],
    );

    return Scaffold(
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );


  }*/
}
