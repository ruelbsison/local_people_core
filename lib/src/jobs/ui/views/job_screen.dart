import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';
import '../widgets/job_card.dart';
//import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:local_people_core/jobs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_people_core/profile.dart';

class JobScreen extends StatefulWidget {
  @override
  _JobScreenState createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  //Completer<void> _refreshCompleter;
  final _scrollController = ScrollController();
  JobBloc _jobBloc;
  
  @override
  void initState() {
    super.initState();

    //_refreshCompleter = Completer<void>();
    _scrollController.addListener(_onScroll);
    _jobBloc = context.read<JobBloc>();
    //int userId = BlocProvider.of<ProfileBloc>(context).profile.id;
    _jobBloc.add(LoadJobs());
    //BlocProvider.of<JobBloc>(context).add(LoadJobs());
  }

  @override
  Widget build(BuildContext context) {
    //final headline6Style = Theme.of(context).textTheme.headline6;
    final appCType = AppConfig.of(context).appType;
    return Scaffold(
      appBar: AppBarWidget(
        //appBarPreferredSize: Size.fromHeight(60.0),
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
    final appCType = AppConfig.of(context).appType;
    return BlocBuilder<JobBloc, JobState>(
      builder: (context, state) {
        if (state is JobLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              _jobBloc.add(RefreshJobs());
            },
            child: ListView.builder(
              itemCount: state.jobs.length,
              itemBuilder: (context, index) =>
              (appCType == AppType.TRADER
                  ? JobCard(job: state.jobs[index])
                  : YourJobCard(job: state.jobs[index])),
            ),
          );
        } if  (state is JobNotLoaded) {
          return const Center(child: Text(''));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    //if (_isBottom) _jobBloc.add(JobFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
