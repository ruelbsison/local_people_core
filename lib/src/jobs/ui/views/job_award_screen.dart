import 'package:flutter/material.dart';
//import 'package:flutter_icons/flutter_icons.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/auth.dart';
import 'package:local_people_core/messages.dart';
import 'package:local_people_core/quote.dart';
import 'package:local_people_core/profile.dart';

import '../widgets/posted_by_widget.dart';
import '../../domain/entities/job.dart';
import '../widgets/job_view_widget.dart';
import '../widgets/job_actions_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/job_bloc.dart';
import '../blocs/job_event.dart';
import '../blocs/job_state.dart';

//import 'package:flutter_svg/flutter_svg.dart';

class JobAwardScreen extends StatefulWidget {
  JobAwardScreen({
    Key key,
    @required this.job,
    @required this.quote,
    @required this.traderProfile,
  }) : super(key: key);

  final Job job;
  final Quote quote;
  final TraderProfile traderProfile;

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
    final appType = AppConfig.of(context).appType;
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
      //title: widget.job.title != null ? widget.job.title : widget.job.description,
      title: widget.traderProfile != null && widget.traderProfile.fullName != null ? widget.traderProfile.fullName : '',
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

  void _showJobAwardProgressDialog(DialogService _dialogService) async {
    StatusDialogResponse dialogResult = await _dialogService.showStatusDialog(
      title: 'Job Award',
      message: 'Sending ...',
    );
    if (dialogResult.status == StatusDialogStatus.SUCCESSFUL) {
      //Future
      //    .delayed(Duration(seconds: 5))
      //    .then((_) => _dialogService.successfulStatusDialogComplete());
      await _dialogService.showSuccessfulStatusDialog(message: 'Job Awarded Successfully!');
      Navigator.of(context).pop();
    } else {
      //Future
      //    .delayed(Duration(seconds: 5))
      //    .then((_) => _dialogService.errorStatusDialogComplete());
      await _dialogService.showErrorStatusDialog(message: 'Job Award Failed!');
      Navigator.of(context).pop();
    }
  }

  Widget buildClientActionWidget(BuildContext context) {
    if (widget.job.awarded == false) {
      return JobActionsWidget(
        job: widget.job,
        traderName: widget.traderProfile.fullName,
        onJobAwardPressed: (message) {
          BlocProvider.of<JobBloc>(context)
              .add(JobAwardEvent(
              job: widget.job,
              quote: widget.quote));
        },
      );
    }

    return SizedBox(height: 5.0);
  }

  Widget buildBody(BuildContext context) {
    final theme = Theme.of(context);
    final appType = AppConfig.of(context).appType;
    BlocProvider.of<ProfileBloc>(context)
        .add(ClientProfileGetEvent(id: widget.job.clientId));
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  JobViewWidget(job: widget.job),
                  SizedBox(height: 20.0),
                  //PostedByWidget(profile: widget.traderProfile),
                  //PostedByWidget(clientId: widget.job.clientId),
                  Container(
                    //color: Colors.white,
                    padding: EdgeInsets.all(12.0),
                      child: Text(
                        'Posted By',
                        textAlign: TextAlign.left,
                        style: theme.textTheme.subtitle1,
                      ),
                  ),
                  //SizedBox(height: 10.0),
                  QuoteCard(
                    job: widget.job,
                    quote: widget.quote,
                    traderProfile: widget.traderProfile,
                    backgroundColor: Colors.white,
                    onQuotePressed: (job, quote, trader) {
                      AppRouter.pushPage(
                          context,
                          DialogManager(
                            child: ProfileScreen(
                              profile: trader,
                            ),
                          ),
                      );
                    },
                  ),
                  SizedBox(height: 30.0),
                  BlocProvider.value(
                  value: BlocProvider.of<JobBloc>(context),
                  child: BlocListener<JobBloc, JobState>(
                    listener: (context, state) {
                      DialogService _dialogService = sl<DialogService>();
                      if (state is JobAwardComplete) {
                        _dialogService.statusDialogComplete(
                            StatusDialogResponse(
                                status: StatusDialogStatus.SUCCESSFUL
                            )
                        );
                      } else if (state is JobAwardFailed){
                        _dialogService.statusDialogComplete(
                            StatusDialogResponse(
                                status: StatusDialogStatus.FAILED
                            )
                        );
                      } else if (state is JobAwarding){
                        _showJobAwardProgressDialog(_dialogService);
                      }
                    },
                    child: buildClientActionWidget(context),
                    // child: BlocProvider(
                    //   create: (context) => ProfileBloc(
                    //     profileRepository: RepositoryProvider.of<ProfileRepository>(context),
                    //     appType: appType,
                    //     authLocalDataSource: sl<AuthLocalDataSource>(),
                    //   )..add(ClientProfileGetEvent(id: widget.job.clientId)),
                    //   child: BlocBuilder<ProfileBloc, ProfileState>(
                    //       builder: (context, state) {
                    //         if (state is ClientProfileGetLoaded) {
                    //           return JobActionsWidget(
                    //             job: widget.job,
                    //             traderName: widget.traderProfile.fullName,
                    //             clientName: state.profile.fullName,
                    //             onJobAwardPressed: (message) {
                    //               BlocProvider.of<JobBloc>(context)
                    //                   .add(JobAwardEvent(
                    //                   job: widget.job,
                    //                   quote: widget.quote));
                    //             },
                    //           );
                    //         } else if (state is ClientProfileGetFailed) {
                    //           return ErrorWidget('Error $state');
                    //         } else {
                    //           return LoadingWidget();
                    //         }
                    //       }
                    //   ),
                    // ),
                  ),
                ),
                  SizedBox(height: 10.0),
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
            )..add(LoadJobMessagesEvent(jobId: widget.quote.jobId)),
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
                      name: widget.job.title,
                      jobId: widget.job.id,
                      traderId: widget.traderProfile.id,
                      clientId: widget.job.clientId,
                      senderId: appType == AppType.TRADER
                          ? widget.traderProfile.id
                          : widget.job.clientId,
                      recipientId: appType == AppType.TRADER
                          ? widget.job.clientId
                          : widget.traderProfile.id,
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
