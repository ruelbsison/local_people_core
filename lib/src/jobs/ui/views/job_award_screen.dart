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
import '../widgets/job_confirmed_action_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/job_bloc.dart';
import '../blocs/job_event.dart';
import '../blocs/job_state.dart';
import '../../domain/entities/change_request.dart';
import '../blocs/change_request_bloc.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
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
  DialogService _dialogService = sl<DialogService>();

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
    // body: SnappingSheet (
    //     // TODO: Add your content that is placed
    //     // behind the sheet. (Can be left empty)
    //   initialSnappingPosition: SnappingPosition.pixels(
    //     positionPixels: 160,
    //     snappingCurve: Curves.bounceOut,
    //     snappingDuration: Duration(seconds: 1),
    //     grabbingContentOffset: GrabbingContentOffset.bottom,
    //   ),
    //     child: buildBody(context),
    //     grabbingHeight: 20.0,
    //   lockOverflowDrag: true,
    //   //grabbing: DefaultGrabbing(),
    //     sheetBelow: SnappingSheetContent(
    //       //sizeBehavior: SheetSizeStatic(size: 100),
    //       // Pass in the scroll controller here!
    //       //childScrollController: _myScrollController,
    //       draggable: false,
    //       // TODO: Add your sheet content here
    //       child: buildClientActionWidget(context),
    //     ),
    //   ),
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

  void _showJobChnageRequestProgressDialog(DialogService dialogService) async {
    StatusDialogResponse dialogResult = await dialogService.showStatusDialog(
      title: 'Job Change Request',
      message: 'Sending ...',
    );
    if (dialogResult.status == StatusDialogStatus.SUCCESSFUL) {
      //Future
      //    .delayed(Duration(seconds: 5))
      //    .then((_) => _dialogService.successfulStatusDialogComplete());
      await dialogService.showSuccessfulStatusDialog(message: 'Change Request Sent Successfully!');
      Navigator.of(context).pop();
    } else {
      //Future
      //    .delayed(Duration(seconds: 5))
      //    .then((_) => _dialogService.errorStatusDialogComplete());
      await dialogService.showErrorStatusDialog(message: 'Change Request Send Failed!');
      Navigator.of(context).pop();
    }
  }

  void _showJobAwardProgressDialog(DialogService dialogService) async {
    StatusDialogResponse dialogResult = await dialogService.showStatusDialog(
      title: 'Job Award',
      message: 'Sending ...',
    );
    if (dialogResult.status == StatusDialogStatus.SUCCESSFUL) {
      //Future
      //    .delayed(Duration(seconds: 5))
      //    .then((_) => _dialogService.successfulStatusDialogComplete());
      await dialogService.showSuccessfulStatusDialog(message: 'Job Awarded Successfully!');
      Navigator.of(context).pop();
    } else {
      //Future
      //    .delayed(Duration(seconds: 5))
      //    .then((_) => _dialogService.errorStatusDialogComplete());
      await dialogService.showErrorStatusDialog(message: 'Job Award Failed!');
      Navigator.of(context).pop();
    }
  }

  Quote findTraderBid(int traderId) => widget.job.bids.firstWhere((quote) => quote.traderId == traderId);

  Widget buildClientActionWidget(BuildContext context) {
    if (widget.job == null)
      return SizedBox(height: 5.0);

    if (widget.job.awarded != null
        && widget.job.awarded == false) {
        return BlocProvider.value(
        value: BlocProvider.of<JobBloc>(context),
        child: BlocListener<JobBloc, JobState>(
          listener: (context, state) {
            if (state is JobAwardComplete) {
              _dialogService.statusDialogComplete(
                  StatusDialogResponse(
                      status: StatusDialogStatus.SUCCESSFUL
                  )
              );
              setState(() {
                widget.job.traderId = state.booking.traderId;
                widget.job.awarded = true;
              });
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
          child: JobActionsWidget(
            job: widget.job,
            traderName: widget.traderProfile.fullName,
            onJobAwardPressed: (message) {
              BlocProvider.of<JobBloc>(context)
                  .add(JobAwardEvent(
                  job: widget.job,
                  quote: widget.quote));
            },
          ),
        ),
      );
    } else if (widget.job.awarded != null
        && widget.job.awarded == true) {
      if (widget.job.bids != null
          && widget.job.bids.length > 0
      && widget.job.traderId != null
      && widget.job.traderId > 0) {
        Quote quote = findTraderBid(widget.job.traderId);
        if (quote != null) {
          return BlocProvider.value(
            value: BlocProvider.of<ChangeRequestBloc>(context),
            child: BlocListener<ChangeRequestBloc, ChangeRequestState>(
              listener: (context, state) {
                if (state is ChangeRequestAdded) {
                  _dialogService.statusDialogComplete(
                      StatusDialogResponse(
                          status: StatusDialogStatus.SUCCESSFUL
                      )
                  );
                  setState(() {
                    if (widget.job.changeRequests == null)
                      widget.job.changeRequests = [];
                    widget.job.changeRequests.add(state.changeRequest);
                  });
                } else if (state is ChangeRequestAddFailed){
                  _dialogService.statusDialogComplete(
                      StatusDialogResponse(
                          status: StatusDialogStatus.FAILED
                      )
                  );
                } else if (state is ChangeRequestAdding){
                  _showJobChnageRequestProgressDialog(_dialogService);
                }
              },
              child: JobConfirmedActionWidget(
                quote: quote,
                onJobChange: (quote) async {
                  JobChangeResponse response = await _dialogService.showJobChangeDialog(
                    startDateTime: quote.deliveryDate,
                    durationInHours: quote.dureationRequired,
                    price: double.parse(quote.totalCost),
                  );
                  if (response != null && response.startDateTime != null
                      && response.durationInHours != null && response.price != null) {
                    ChangeRequest changeRequest = ChangeRequest(
                      date: response.startDateTime,
                      duration: response.durationInHours,
                      traderId: quote.traderId,
                      jobId: quote.jobId,
                      status: 'Change Required',
                      clinetId: widget.job.clientId,
                    );
                    BlocProvider.of<ChangeRequestBloc>(context)
                        .add((ChangeRequestAddEvent(changeRequest: changeRequest )));
                  }
                },
                onJobCencel: (quote) {

                },
              ),
            ),
          );
        }
      }
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
            child: Column(
            children: <Widget> [
              Container(
                margin: EdgeInsets.all(12.0),
                padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                //color: Color.fromRGBO(255, 255, 255, 1),
                child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    JobViewWidget(job: widget.job),
                    SizedBox(height: 10.0),
                    //PostedByWidget(profile: widget.traderProfile),
                    //PostedByWidget(clientId: widget.job.clientId),
                    Container(
                      //color: Colors.white,
                      padding: EdgeInsets.all(12.0),
                        child: Text(
                            (widget.job != null && widget.job.awarded != null
                                && widget.job.traderId != null  && widget.job.awarded == true )
                              ? LocalPeopleLocalizations.of(context).titleAcceptedBid
                              : LocalPeopleLocalizations.of(context).titlePostedBy,
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
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
              buildClientActionWidget(context),
              // BlocProvider.value(
              //   value: BlocProvider.of<JobBloc>(context),
              //   child: BlocListener<JobBloc, JobState>(
              //     listener: (context, state) {
              //       if (state is JobAwardComplete) {
              //         _dialogService.statusDialogComplete(
              //             StatusDialogResponse(
              //                 status: StatusDialogStatus.SUCCESSFUL
              //             )
              //         );
              //         setState(() {
              //           widget.job.traderId = state.booking.traderId;
              //           widget.job.awarded = true;
              //         });
              //       } else if (state is JobAwardFailed){
              //         _dialogService.statusDialogComplete(
              //             StatusDialogResponse(
              //                 status: StatusDialogStatus.FAILED
              //             )
              //         );
              //       } else if (state is JobAwarding){
              //         _showJobAwardProgressDialog(_dialogService);
              //       }
              //     },
              //     child: buildClientActionWidget(context),
              //   ),
              // ),
            ]
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
