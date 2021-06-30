import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';
import '../widgets/job_card.dart';
import '../widgets/your_job_card.dart';
//import 'package:flutter_search_bar/flutter_search_bar.dart';
import '../blocs/job_bloc.dart';
import '../blocs/job_event.dart';
import '../blocs/job_state.dart';
import '../blocs/location_bloc.dart';
import '../../domain/entities/job.dart';
import '../../domain/job_provider.dart';
import '../../domain/repositories/job_repository.dart';
import '../../domain/repositories/tag_repository.dart';
import '../../domain/repositories/location_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_people_core/profile.dart';
import 'package:local_people_core/quote.dart';
import 'package:local_people_core/auth.dart';
import 'package:local_people_core/core.dart';
import '../views/job_detail_screen.dart';
import '../views/job_bid_screen.dart';
import 'package:provider/provider.dart';
import '../widgets/job_body_container.dart';

class JobScreen extends StatefulWidget {
  JobScreen({
    Key key,
  }) : super(key: key);

  @override
  _JobScreenState createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> with TickerProviderStateMixin {
  List<Job> jobs = [];
  List<Job> allJobs = [];
  List<Job> requestedJobs = [];
  List<Job> allRequestedJobs = [];
  int traderId = 0;
  String lastJobsFilter;
  String lastRequestedJobsFilter;
  int totalJobsOppurtunities = 0;

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

  TabController _controller;
  int _tab = 0;

  //Job findJob(int id) => Provider.of<JobProvider>(context, listen: false).jobs.firstWhere((job) => job.id == id);
  Job findJob(int id) => jobs.firstWhere((job) => job.id == id);

  Job findRequestedJob(int id) => requestedJobs.firstWhere((job) => job.id == id);

  JobBloc _jobBloc;
  QuoteRequestBloc _quoteRequestBloc;
  //LocationBloc _locationBloc;
  QuoteBloc _quoteBloc;

  @override
  void didChangeDependencies() {
    // try {
    //   _jobBloc = BlocProvider.of<JobBloc>(context);
    //   _quoteRequestBloc = BlocProvider.of<QuoteRequestBloc>(context);
    //   _quoteBloc = BlocProvider.of<QuoteBloc>(context);
    //
    //   final appType = AppConfig.of(context).appType;
    //   if (appType == AppType.CLIENT) {
    //     _jobBloc.add(LoadJobs());
    //   } else {
    //     _jobBloc.add(LoadOpportunities());
    //     if (traderId > 1)
    //       _quoteRequestBloc.add(QuoteRequestLoadEvent(traderId: traderId));
    //   }
    // } catch (e) {
    //   print(e.toString());
    // }
    print('JobScreen.didChangeDependencies');
  }

  @override
  void initState() {
    super.initState();

    try {
      TraderProfile traderProfile = sl<TraderProfile>();
      if (traderProfile != null)
        traderId = traderProfile.id;
    } catch (e) {
      print(e.toString());
    }

    _controller = TabController(length: 2, vsync: this);
    // _controller.addListener(() {
    //   if (_controller.index == 0) {
    //     if (lastJobsFilter.compareTo(filterValue) != 0) {
    //       setState(() {
    //         jobs.clear();
    //         jobs = filterJobs(allJobs);
    //         lastJobsFilter = filterValue;
    //       });
    //     }
    //   } else {
    //     if (lastRequestedJobsFilter.compareTo(filterValue) != 0) {
    //       setState(() {
    //         requestedJobs.clear();
    //         requestedJobs = filterJobs(allRequestedJobs);
    //         lastRequestedJobsFilter = filterValue;
    //       });
    //     }
    //   }
    // });

    print('JobScreen.initState');
  }

  @override
  Widget build(BuildContext context) {
    print('JobScreen.build');
    // if (lastJobsFilter.compareTo(filterValue) != 0) {
    //   setState(() {
    //     if (_controller.index == 0) {
    //       jobs.clear();
    //       jobs = filterJobs(allJobs);
    //       lastJobsFilter = filterValue;
    //     }
    //   });
    // }
    // if (lastRequestedJobsFilter.compareTo(filterValue) != 0) {
    //   setState(() {
    //     if (_controller.index == 1) {
    //       requestedJobs.clear();
    //       requestedJobs = filterJobs(allRequestedJobs);
    //       lastRequestedJobsFilter = filterValue;
    //     }
    //   });
    // }

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
        title: (appCType == AppType.TRADER
            ? LocalPeopleLocalizations.of(context).menuTitleOpportunities
            : LocalPeopleLocalizations.of(context).menuTitleYourJobs),
        subTitle: totalJobsOppurtunities != null
            ? totalJobsOppurtunities.toString() + " Opportunities in your area today" : '',
        searchTitle: 'Search Opportunities',
        appBar: AppBar(),
        bottom: buildAppBarBottom(context),
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(1.0),
        //   child: Container(
        //     decoration: BoxDecoration(
        //       color: Colors.white,
        //       border: Border(
        //         bottom: BorderSide(
        //           color: Color.fromRGBO(186, 207, 216, 1),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.search),
        //     onPressed: () {},
        //   ),
        // ],
      ),
      body: buildBody(context),
      // body: MultiBlocProvider(
      //   providers: [
      //     BlocProvider(
      //       create: (context) => JobBloc(
      //         jobRepository: RepositoryProvider.of<JobRepository>(context),
      //         tagRepository: RepositoryProvider.of<TagRepository>(context),
      //         locationRepository: RepositoryProvider.of<LocationRepository>(context),
      //         quoteRepository: RepositoryProvider.of<QuoteRepository>(context),
      //         quoteRequestRepository: RepositoryProvider.of<QuoteRequestRepository>(context),
      //         appType: AppConfig.of(context).appType,
      //         authLocalDataSource: sl<AuthLocalDataSource>(),
      //       ),
      //     ),
      //     // BlocProvider(
      //     //   create: (context) => QuoteBloc(
      //     //     quoteRepository: RepositoryProvider.of<QuoteRepository>(context),
      //     //     authLocalDataSource: sl<AuthLocalDataSource>(),
      //     //   ),
      //     // ),
      //     BlocProvider(
      //       create: (context) => QuoteRequestBloc(
      //         quoteRequestRepository: RepositoryProvider.of<QuoteRequestRepository>(context),
      //       ),
      //     ),
      //   ],
      //   child: buildBody(context),
      // ),
      // body: BlocProvider.value(value: context.read<JobBloc>(),
      //   child: BlocProvider.value(value: context.read<QuoteRequestBloc>(),
      //     child: buildBody(context),
      //   )
      // ),
    );
  }

  PreferredSizeWidget buildAppBarBottom(BuildContext context) {
    final appType = AppConfig.of(context).appType;
    if (appType == AppType.CLIENT) return null;

    final theme = Theme.of(context);
    return TabBar(
      controller: _controller,
      automaticIndicatorColorAdjustment: false,
      //unselectedLabelColor: Color.fromRGBO(239, 244, 246, 1), //theme.primaryColor,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorColor: Color.fromRGBO(170, 186, 205, 1),
      labelStyle: theme.textTheme.bodyText1,
      unselectedLabelStyle: theme.textTheme.bodyText1
          .copyWith(fontWeight: FontWeight.normal),
      //indicatorPadding: EdgeInsets.only(top: 12),
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
              "REQUESTED JOBS",
              style: theme.textTheme.bodyText2,
            ),
          ),
        ),
      ],
    );
  }

  void onFilterValueChanged(String value) {
    setState(() {
      filterValue = value;
      // if (_controller.index == 0) {
      //   jobs.clear();
      //   jobs = filterJobs(allJobs);
      //   lastJobsFilter = filterValue;
      // } else {
      //   requestedJobs.clear();
      //   requestedJobs = filterJobs(allRequestedJobs);
      //   lastRequestedJobsFilter = filterValue;
      // }
    });
  }

  Widget buildBody(BuildContext context) {
    final theme = Theme.of(context);
    final appType = AppConfig.of(context).appType;
    return SafeArea(
      child: appType == AppType.CLIENT
          ? buildJobBody(context)
          : TabBarView(
              controller: _controller,
              children: <Widget>[
                buildJobBody(context),
                buildRequestedJobsBody(context),
              ],
            ),
    );
  }

  Widget buildRequestedJobsBody(BuildContext context) {
    if (requestedJobs != null && requestedJobs.length > 0)
      return buildRequestedJobList(context);

    BlocProvider.of<QuoteRequestBloc>(context)
      .add(QuoteRequestLoadEvent(traderId: traderId));
    return BlocProvider.value(
      value: BlocProvider.of<QuoteRequestBloc>(context),
      child: BlocBuilder<QuoteRequestBloc, QuoteRequestState>(
        builder: (context, state) {
          if (state is QuoteRequestLoaded) {
            state.quoteRequests.forEach((quoteRequest) {
              //Job findJob(int id) => jobs.firstWhere((job) => job.id == id);
              Job requestedJob = findJob(quoteRequest.jobId);
              if (requestedJob != null) {
                if (requestedJob.quoteRequests == null)
                  requestedJob.quoteRequests = [];
                requestedJob.quoteRequests.add(quoteRequest);

                int index = allRequestedJobs.indexOf(requestedJob);
                if (index == -1)
                  allRequestedJobs.add(requestedJob);
                else {
                  allRequestedJobs.removeAt(index);
                  allRequestedJobs.insert(index, requestedJob);
                }
              }
            });
            //requestedJobs = filterJobs(allRequestedJobs);
            //lastRequestedJobsFilter = filterValue;
            return buildRequestedJobList(context);
          } else if (state is QuoteRequestLoadFailed) {
            print('Error $state');
            return buildRequestedJobList(context);
          } else {
            //return const Center(child: CircularProgressIndicator());
            return LoadingWidget();
          }
        },
      ),
    );
  }

  Widget buildRequestedJobList(BuildContext context) {
    requestedJobs.clear();
    requestedJobs = filterJobs(allRequestedJobs);
    lastRequestedJobsFilter = filterValue;
    if (_controller.index == 0) {
      //setState(() {
        totalJobsOppurtunities = requestedJobs.length;
      //});
    }
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            allRequestedJobs.clear();
            requestedJobs.clear();
          });
          try {
            TraderProfile traderProfile = sl<TraderProfile>();
            if (traderProfile != null)
              context.read<QuoteRequestBloc>()
                  .add(QuoteRequestLoadEvent(traderId: traderProfile.id));
          } catch (e) {
            print(e.toString());
          }
        },
        child: ListView.builder(
            itemCount: requestedJobs != null ? requestedJobs.length : 9,
            itemBuilder: (context, index) {
              return createJobCard(requestedJobs[index]);
            }),
      ),
    );
  }

  Widget buildJobList(BuildContext context) {
    jobs.clear();
    jobs = filterJobs(allJobs);
    lastJobsFilter = filterValue;

    if (_controller.index == 0) {
      //setState(() {
        totalJobsOppurtunities = jobs.length;
      //});
    }
    final appCType = AppConfig.of(context).appType;
    //var jobProvider = context.watch<JobProvider>();
    //var jobProvider = Provider.of<JobProvider>(context, listen: false);
    return SafeArea(
      child: JobBodyContainer(
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            allJobs.clear();
            jobs.clear();
          });
          if (appCType == AppType.CLIENT)
            context.read<JobBloc>().add(RefreshJobs());
          else
            context.read<JobBloc>().add(RefreshOpportunities());
        },
        child: ListView.builder(
            itemCount:  jobs != null ? jobs.length : 0,
            itemBuilder: (context, index) {
              Job job = jobs[index];
              final appType = AppConfig
                  .of(context)
                  .appType;
              if (appType == AppType.TRADER)
                return JobCard(job: job);
              else
                return YourJobCard(job: job);
              // return BlocProvider(
              //   create: (context) =>
              //       QuoteBloc(
              //         quoteRepository: RepositoryProvider.of<QuoteRepository>(
              //             context),
              //         authLocalDataSource: sl<AuthLocalDataSource>(),
              //       ),
              //   child: JobCard(
              // return JobCard(
              //     job: jobs[index],
              //     onJobLocationUpdateCallback: (jobId, location) {
              //       if (location == null || jobId == null || jobId < 0)
              //         return;
              //
              //       //Job findJob(int id) => jobs.firstWhere((job) => job.id == id);
              //       Job job = findJob(jobId);
              //       if (job != null) {
              //         //setState(() {
              //         job.location = location;
              //         int index = jobs.indexOf(job);
              //         if (index >= 0) {
              //           jobs[index] = job;
              //         }
              //         //});
              //       }
              //     },
              //     onJobBidsUpdateCallback: (jobId, bids) {
              //       if (jobId == null || jobId < 0 || bids == null ||
              //           bids.length == 0)
              //         return;
              //
              //       //Job findJob(int id) => jobs.firstWhere((job) => job.id == id);
              //       Job job = findJob(jobId);
              //       if (job != null) {
              //         if (bids != null) {
              //           //setState(() {
              //           if (job.bids == null)
              //             job.bids = [];
              //           else
              //             job.bids.clear();
              //           job.bids = bids;
              //           int index = jobs.indexOf(job);
              //           if (index >= 0) {
              //             jobs[index] = job;
              //           }
              //           //});
              //         }
              //       }
              //     },
              //   //),
              // );
            }),
            //}
              ),
      ),
      );
    //);
  }

  Widget buildJobBody(BuildContext context) {
    if (allJobs != null && allJobs.length > 0)
      return buildJobList(context);

    final appCType = AppConfig.of(context).appType;
    if (appCType == AppType.CLIENT) {
      //if (Provider.of<JobProvider>(context, listen: false).filteredJobs.length == 0)
      BlocProvider.of<JobBloc>(context).add(LoadJobs());
    } else {
      //if (Provider.of<JobProvider>(context, listen: false).filteredJobs.length == 0)
      BlocProvider.of<JobBloc>(context).add(LoadOpportunities());
     }
    return BlocProvider.value(
      value: BlocProvider.of<JobBloc>(context),
      child: BlocBuilder<JobBloc, JobState>(
        builder: (context, state) {
          if (state is JobLoaded) {
            allJobs.clear();
            allJobs.addAll(state.jobs);
            // jobs.clear();
            // jobs = filterJobs(allJobs);
            // lastJobsFilter = filterValue;
            // if (jobs.length > 0) {
            //   Job job = jobs[0];
            //   //BlocProvider.of<QuoteBloc>(context)
            //   //    .add(QuoteJobLoadEvent(id: job.id));
            // }
            return buildJobList(context);
          } else if (state is OpportunitiesLoaded) {
            allJobs.clear();
            allJobs.addAll(state.jobs);
            // jobs.clear();
            // jobs = filterJobs(allJobs);
            // lastJobsFilter = filterValue;
            // if (jobs.length > 0) {
            //   Job job = jobs[0];
            //   BlocProvider.of<QuoteBloc>(context)
            //       .add(QuoteJobLoadEvent(id: job.id));
            // }
            return buildJobList(context);
          } else if (state is JobNotLoaded) {
            print('Error $state');
            return buildJobList(context);
          } else if (state is OpportunitiesNotLoaded) {
            print('Error $state');
            return buildJobList(context);
          } else {
            return LoadingWidget();
          }
        },
      ),
    );
    // return BlocProvider.value(
    //   value: BlocProvider.of<QuoteBloc>(context),
    //   child: BlocListener<QuoteBloc, QuoteState>(
    //     listenWhen: (previousState, state) {
    //       if (state is QuoteJobLoaded) {
    //         return true;
    //       } else if (state is QuoteJobLoadFailed) {
    //         return true;
    //       }
    //       return false;
    //     },
    //     listener: (context, state) {
    //       if (state is QuoteJobLoaded) {
    //         if (state.quotes.length > 0) {
    //           int index = -1;
    //           int jobId = state.quotes.first.jobId;
    //           Job job = findJob(jobId);
    //           if (job == null)
    //             return;
    //
    //           index = jobs.indexOf(job);
    //           if (job.bids == null)
    //             job.bids = [];
    //           else
    //             job.bids.clear();
    //           if (state.quotes != null && state.quotes.length > 0) {
    //             print('state.quotes.length: ' + state.quotes.length.toString());
    //             job.bids.addAll(state.quotes);
    //             if (index >= 0) {
    //               setState(() {
    //                 jobs[index] = job;
    //               });
    //             }
    //           }
    //
    //           if ((index+1) < jobs.length) {
    //             Job job = jobs[index+1];
    //             BlocProvider.of<QuoteBloc>(context)
    //                 .add(QuoteJobLoadEvent(id: job.id));
    //           }
    //         }
    //       } else if (state is QuoteJobLoadFailed) {
    //
    //       }
    //     },
    //     child: BlocProvider.value(
    //       value: BlocProvider.of<JobBloc>(context),
    //       child: BlocBuilder<JobBloc, JobState>(
    //         builder: (context, state) {
    //           if (state is JobLoaded) {
    //             allJobs.clear();
    //             allJobs.addAll(state.jobs);
    //             jobs.clear();
    //             jobs = filterJobs(allJobs);
    //             if (jobs.length > 0) {
    //               Job job = jobs[0];
    //               BlocProvider.of<QuoteBloc>(context)
    //                   .add(QuoteJobLoadEvent(id: job.id));
    //             }
    //             return buildJobList(context);
    //           } else if (state is OpportunitiesLoaded) {
    //             allJobs.clear();
    //             allJobs.addAll(state.jobs);
    //             jobs.clear();
    //             jobs = filterJobs(allJobs);
    //             if (jobs.length > 0) {
    //               Job job = jobs[0];
    //               BlocProvider.of<QuoteBloc>(context)
    //                   .add(QuoteJobLoadEvent(id: job.id));
    //             }
    //             return buildJobList(context);
    //           } else if (state is JobNotLoaded) {
    //             print('Error $state');
    //             return buildJobList(context);
    //           } else if (state is OpportunitiesNotLoaded) {
    //             print('Error $state');
    //             return buildJobList(context);
    //           } else {
    //             return LoadingWidget();
    //           }
    //         },
    //       ),
    //     ),
    //     //SizedBox(height: 5.0),
    //   ),
    // );
  }

  List<Job> filterJobs(List<Job> jobList) {
    List<Job> filteredJobs = jobList.where((job) {
      if (filterValue.startsWith('Expiry') == true) {
        DateTime tom = job.date.add(Duration(days: 1));
        if (job.date != null && tom.isAtSameMomentAs(DateTime.now())) {
          return true;
        }
        return false;
      } else if (filterValue.startsWith('Value') == true) {
        return false;
      } else if (filterValue.startsWith('Bids') == true) {
        if (job.bids != null && (job.bids.length > 0) == true) {
          return true;
        }
        return false;
      } else if (filterValue.startsWith('Packages') == true) {
        if (job.private != null && job.private == true) {
          return true;
        }
        return false;
      } else if (filterValue.startsWith('Clients') == true) {
        return false;
      } else if (filterValue.startsWith('Posted') == true) {
        if (job.isPosted != null && job.isPosted == true) {
          return true;
        }
        return false;
      } else if (filterValue.startsWith('Awarded') == true) {
        if (job.awarded != null && job.awarded == true) {
          return true;
        }
        return false;
      } else if (filterValue.startsWith('Confirmed') == true) {
        if (job.isConfirmed != null && job.isConfirmed == true) {
          return true;
        }
        return false;
      } else if (filterValue.startsWith('Completed') == true) {
        if (job.isCompleted != null && job.isCompleted == true) {
          return true;
        }
        return false;
      }
      return true;
    }).toList();

    return filteredJobs;
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
        });
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
        });
    //return YourJobCard(job: job);
  }

  @override
  void dispose() {
    _scrollController.dispose();

    // _jobBloc.dispose();
    // _quoteRequestBloc.dispose();
    // //_locationBloc.dispose();
    // _quoteBloc.dispose();

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
