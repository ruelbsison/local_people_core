import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';
import '../widgets/job_card.dart';
import '../widgets/your_job_card.dart';
//import 'package:flutter_search_bar/flutter_search_bar.dart';
import '../blocs/job_bloc.dart';
import '../blocs/job_event.dart';
import '../blocs/job_state.dart';
import '../../domain/entities/job.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_people_core/profile.dart';
import '../views/job_detail_screen.dart';
import '../views/job_bid_screen.dart';

class JobScreen extends StatefulWidget {
  JobScreen({
    Key key,
  }) : super(key: key);

  List<Job> jobs = [];

  @override
  _JobScreenState createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  //Completer<void> _refreshCompleter;
  final _scrollController = ScrollController();
  //JobBloc _jobBloc;
 final List<String> _traderFilterItem = [
   "All",
   "Expiry",
   "Value",
   "Packages",
   "Bids",
   "Client",
 ];

  final List<String> _clientFilterItem = [
    "All",
    "Posted",
    "Bids \ Quotes",
    "Awarded",
    "Confirmed",
    "Completed",
  ];

  String filterValue = 'All';

  @override
  void initState() {
    super.initState();

    //_refreshCompleter = Completer<void>();
    _scrollController.addListener(_onScroll);
    //_jobBloc = context.read<JobBloc>();
    //int userId = BlocProvider.of<ProfileBloc>(context).profile.id;
    //_jobBloc.add(LoadJobs());
    //BlocProvider.of<JobBloc>(context).add(LoadJobs());
  }

  @override
  Widget build(BuildContext context) {
    //final headline6Style = Theme.of(context).textTheme.headline6;
    final appCType = AppConfig.of(context).appType;
    return Scaffold(
      appBar: AppBarWidget(
        //appBarPreferredSize: Size.fromHeight(60.0),
          showFilter: true,
        filterValue: filterValue,
        filterItems: (appCType == AppType.TRADER
            ? _traderFilterItem
            : _clientFilterItem),
        onFilterValueChanged: onFilterValueChanged,
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

  void onFilterValueChanged(String value) {
    setState(() {
      filterValue = value;
    });
  }

  Widget buildBody(BuildContext context) {
    final appCType = AppConfig.of(context).appType;
    if (appCType == AppType.CLIENT)
      context.read<JobBloc>().add(LoadJobs());
    else
      context.read<JobBloc>().add(LoadOpportunities());
    return BlocProvider.value(
      value: context.read<JobBloc>(),
      child: BlocBuilder<JobBloc, JobState>(
        builder: (context, state) {
          if (state is JobLoaded) {
            //setState(() {
              widget.jobs = state.jobs;
            //});
            return buildBodyList(context);
          } else if (state is OpportunitiesLoaded) {
            //setState(() {
              widget.jobs = state.jobs;
            //});
            return buildBodyList(context);
          } else if (state is JobNotLoaded) {
            return ErrorWidget('Error $state');
          }
          if (state is OpportunitiesNotLoaded) {
            return ErrorWidget('Error $state');
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget buildBodyList(BuildContext context) {
    final appCType = AppConfig.of(context).appType;
    List<Job> tmp = widget.jobs;
    widget.jobs = tmp.where((job) {
      if (filterValue.startsWith('Expiry') == true) {
        DateTime tom = job.date.add(Duration(days: 1));
        if (job.date != null
            && tom.isAtSameMomentAs(DateTime.now())) {
          return true;
        }
        return false;
      } else if (filterValue.startsWith('Value') == true) {
        return false;
      } else if (filterValue.startsWith('Bids') == true) {
        if (job.bids != null
            && (job.bids.length > 0) == true) {
          return true;
        }
        return false;
      } else if (filterValue.startsWith('Packages') == true) {
        if (job.private != null
            && job.private == true) {
          return true;
        }
        return false;
      } else if (filterValue.startsWith('Clients') == true) {
        return false;
      } else if (filterValue.startsWith('Posted') == true) {
        if (job.isPosted != null
            && job.isPosted == true) {
          return true;
        }
        return false;
      } else if (filterValue.startsWith('Awarded') == true) {
        if (job.awarded != null
            && job.awarded == true) {
          return true;
        }
        return false;
      } else if (filterValue.startsWith('Confirmed') == true) {
        if (job.isConfirmed != null
            && job.isConfirmed == true) {
          return true;
        }
        return false;
      } else if (filterValue.startsWith('Completed') == true) {
        if (job.isCompleted != null
            && job.isCompleted == true) {
          return true;
        }
        return false;
      }
      return true;
    }).toList();
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          if (appCType == AppType.CLIENT)
            context.read<JobBloc>().add(RefreshJobs());
          else
            context.read<JobBloc>().add(RefreshOpportunities());
        },
        child: ListView.builder(
          itemCount: widget.jobs.length,
          itemBuilder: (context, index) {
            final appCType = AppConfig.of(context).appType;
            if (appCType == AppType.TRADER) {
              return createJobCard(widget.jobs[index]);
            } else {
              return createYourJobCard(widget.jobs[index]);
            }
          }
        ),
      ),
    );
  }

  // Widget createJob(int index) {
  //   widget.jobs[index].entityStatus = EntityStatus.ENTIRY_STATUS_LOADING;
  //   BlocProvider.of<JobBloc>(context)
  //       .add(JobGetEvent(jobId: widget.jobs[index].id));
  //   return BlocBuilder<JobBloc, JobState>(
  //     bloc: BlocProvider.of<JobBloc>(context),
  //     builder: (BuildContext context, JobState state) {
  //       final appCType = AppConfig.of(context).appType;
  //       if (state is JobGetLoaded) {
  //         setState(() {
  //           widget.jobs[index] = state.job;
  //           widget.jobs[index].entityStatus = EntityStatus.ENTIRY_STATUS_COMPLETED;
  //         });
  //         if (appCType == AppType.TRADER) {
  //           return createJobCard(widget.jobs[index]);
  //         } else {
  //           return createYourJobCard(widget.jobs[index]);
  //         }
  //       } else if (state is JobGetFailed) {
  //         setState(() {
  //           widget.jobs[index] = state.job;
  //           widget.jobs[index].entityStatus = EntityStatus.ENTIRY_STATUS_COMPLETED;
  //         });
  //
  //         if (appCType == AppType.TRADER) {
  //           return createJobCard(widget.jobs[index]);
  //         } else {
  //           return createYourJobCard(widget.jobs[index]);
  //         }
  //       } else {
  //         return LoadingWidget();
  //       }
  //     },
  //   );
  // }

  Widget createJobCard(Job job) {
    return InkWell(
        child: JobCard(job: job),
        onTap: () {
          AppRouter.pushPage(
              context,
              DialogManager(
                child: JobDetailScreen(
                  job: job,
                ),
              ));
        }
    );
    //return JobCard(job: job);
  }

  Widget createYourJobCard(Job job) {
    return InkWell(
        child: YourJobCard(job: job),
        onTap: () {
          AppRouter.pushPage(
              context,
              DialogManager(
                child: JobBidScreen(
                  job: job,
                ),
              ));
        }
    );
    return YourJobCard(job: job);
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
