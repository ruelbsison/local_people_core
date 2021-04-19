import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';
import '../widgets/job_card.dart';
//import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:local_people_core/jobs.dart';

class JobScreen extends StatefulWidget {
  @override
  _JobScreenState createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final headline6Style = Theme.of(context).textTheme.headline6;
    final appCType = AppConfig.of(context).appType;
    return Scaffold(
      appBar: AppBarWidget(
        appBarPreferredSize: Size.fromHeight(60.0),
        subTitle: (appCType == AppType.TRADER
            ? LocalPeopleLocalizations.of(context).menuTitleOpportunities
            : LocalPeopleLocalizations.of(context).menuTitleYourJobs),
        appBar: AppBar(),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Color.fromRGBO(186, 207, 216, 1),
                ),
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: (appCType == AppType.TRADER
          ? buildTraderBody(context)
          : buildClientBody(context)),
    );
  }

  Widget buildTraderBody(BuildContext context) {
    return SafeArea (
      /*child: RefreshIndicator(
          onRefresh: () async{
        BlocProvider.of<HomeBloc>(context).add(RefreshHome());
      },
      child: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          //SizedBox(height: 10.0),
          OpportunityCard(),
          //SizedBox(height: 10.0),
          OpportunityCard(),
          //SizedBox(height: 10.0),
          OpportunityCard(),
          //SizedBox(height: 10.0),
          OpportunityCard(),
          //SizedBox(height: 10.0),
        ],
      )*/
      child: ListView.builder(
        itemCount: demeJobs.length,
        itemBuilder: (context, index) =>
            JobCard(job: demeJobs[index]),
      ),
    );
  }

  Widget buildClientBody(BuildContext context) {
    return SafeArea (
      /*child: RefreshIndicator(
          onRefresh: () async{
        BlocProvider.of<HomeBloc>(context).add(RefreshHome());
      },
      child: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          //SizedBox(height: 10.0),
          OpportunityCard(),
          //SizedBox(height: 10.0),
          OpportunityCard(),
          //SizedBox(height: 10.0),
          OpportunityCard(),
          //SizedBox(height: 10.0),
          OpportunityCard(),
          //SizedBox(height: 10.0),
        ],
      )*/
      child: ListView.builder(
        itemCount: demeJobs.length,
        itemBuilder: (context, index) =>
            YourJobCard(job: demeJobs[index]),
      ),
    );
  }
}
