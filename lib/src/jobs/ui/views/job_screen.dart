import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';
import '../widgets/job_card.dart';
//import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:local_people_core/jobs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return BlocBuilder<JobBloc, JobState>(
      builder: (context, state) {
        return SafeArea (
            child: buildBodyList(state),
        );
      },
    );
  }

  Widget buildBodyList(JobState state) {
    final appCType = AppConfig.of(context).appType;
    if (state is JobLoaded) {
      return Expanded(
        child: RefreshIndicator(
            onRefresh: () async{
            BlocProvider.of<JobBloc>(context).add(RefreshJobs());
          },
          child: ListView.builder(
            itemCount: demeJobs.length,
            itemBuilder: (context, index) =>
            (appCType == AppType.TRADER
                ? JobCard(job: state.jobs[index])
                : YourJobCard(job: state.jobs[index])),
          ),
        ),
      );
    } else if (state is JobLoading) {
      return Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (state is JobNotLoaded) {
      return Expanded(
        child: Center(
          child: Text('Cannot load data'),
        ),
      );
    } else {
      return Expanded(
        child: Center(
          child: Text('Unknown state'),
        ),
      );
    }
  }
}
