import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/auth.dart';
import 'package:local_people_core/messages.dart';
import 'package:local_people_core/profile.dart';
import 'package:local_people_core/quote.dart';
import 'package:local_people_core/jobs.dart';

import '../widgets/posted_by_widget.dart';
import '../../domain/entities/job.dart';
import '../widgets/job_view_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import '../widgets/job_bid_actions_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_people_core/quote.dart';
import '../widgets/bid_pending_action_widget.dart';
import '../widgets/bid_pending_deposit_action_widget.dart';

class JobDetailScreen extends StatefulWidget {
  JobDetailScreen(
      {Key key,
      @required this.job,
      this.appBarPreferredSize = const Size.fromHeight(180.0)})
      : super(key: key);

  final Job job;
  final Size appBarPreferredSize;

  @override
  _JobDetailScreenState createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen>
    with TickerProviderStateMixin {
  TabController _controller;
  int _tab = 0;
  int traderId = 0;

  DialogService _dialogService = sl<DialogService>();

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
    // return Scaffold(
    //   appBar: buildAppBar(),
    //   body: SnappingSheet(
    //     // TODO: Add your content that is placed
    //     // behind the sheet. (Can be left empty)
    //     child: buildBody(context),
    //     grabbingHeight: 40,
    //     grabbing: DefaultGrabbing(),
    //     sheetBelow: SnappingSheetContent(
    //       // Pass in the scroll controller here!
    //       //childScrollController: _myScrollController,
    //       draggable: true,
    //       // TODO: Add your sheet content here
    //       child: JobBidActionsWidget(job: widget.job,),
    //     ),
    //   ),
    // );
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
      title:
          widget.job.title != null ? widget.job.title : widget.job.description,
      // leading: Text(
      //   (appCType == AppType.TRADER
      //       ? LocalPeopleLocalizations.of(context).menuTitleOpportunities
      //       : LocalPeopleLocalizations.of(context).menuTitleYourJobs),
      //   style: theme.textTheme.caption,
      // ),
      packageSvgAssetIcon: ((widget.job.date != null
          && (widget.job.date.difference(DateTime.now())).inDays > 0)
          ? 'packages/local_people_core/assets/images/package-green.svg'
          : 'packages/local_people_core/assets/images/package-orange.svg'),
      leadingText: (appType == AppType.TRADER
          ? LocalPeopleLocalizations.of(context).menuTitleOpportunities
          : LocalPeopleLocalizations.of(context).menuTitleYourJobs),
      startrDateTime: widget.job.date,
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
                "MESSAGES",
                style: theme.textTheme.bodyText2,
              ),
            ),
          ),
        ],
      ),
    ); //
  }

  Quote findTraderBid(int traderId) => widget.job.bids.firstWhere((quote) => quote.traderId == traderId);

  Widget buildTradeAction(BuildContext context) {
    if (widget.job == null)
      return SizedBox(height: 5.0);

    if (widget.job.awarded != null
        && widget.job.awarded == false) {
      if (widget.job.bids != null
          && widget.job.bids.length > 0) {
        Quote quote = findTraderBid(traderId);
        if (quote != null) {
          return BidPendingActionWidget();
        } else {
          return JobBidActionsWidget(
            job: widget.job,
            traderId: traderId,
          );
        }
      } else {
        return JobBidActionsWidget(
          job: widget.job,
          traderId: traderId,
        );
      }
    } else if (widget.job.awarded != null
        && widget.job.awarded == true
        && widget.job.traderId != null
        && widget.job.traderId == traderId) {
      if (widget.job.bids != null
          && widget.job.bids.length > 0) {
        Quote quote = findTraderBid(traderId);
        return BidPendingDepositActionWidget(
          createdAt: quote.createdAt,
        );
      }
    }
    return SizedBox(height: 5.0);
  }

  Widget buildBody(BuildContext context) {
    final theme = Theme.of(context);
    final appType = AppConfig.of(context).appType;
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
              //padding: EdgeInsets.all(12.0),
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  JobViewWidget(job: widget.job),
                  SizedBox(height: 10.0),
                  PostedByWidget(
                    clientId: widget.job.clientId,
                  ),
                  Container(
                    color: Colors.white,
                    child: ElevatedButton(
                        onPressed: () {
                          _sendMessage(context);
                        },
                        child: Text(
                          LocalPeopleLocalizations.of(context)
                              .btnTitleSendMesssage,
                          style: theme.textTheme.button
                              .copyWith(color: Colors.white),
                        )),
                  ),
                  SizedBox(height: 10.0),
                  // BlocProvider(
                  //   create: (context) => QuoteBloc(
                  //     quoteRepository:
                  //         RepositoryProvider.of<QuoteRepository>(context),
                  //     profileRepository:
                  //         RepositoryProvider.of<ProfileRepository>(context),
                  //     jobRepository:
                  //         RepositoryProvider.of<JobRepository>(context),
                  //     authLocalDataSource: sl<AuthLocalDataSource>(),
                  //   ),
                ],
              ),
            ),
              BlocProvider.value(
                value: BlocProvider.of<QuoteBloc>(context),
                child: BlocListener<QuoteBloc, QuoteState>(
                  listenWhen: (previousState, state) {
                    if (state is QuoteAdding) {
                      return true;
                    } else if (state is QuoteAddFailed) {
                      return true;
                    } else if (state is QuoteAdded) {
                      return true;
                    }
                    return false;
                  },
                  listener: (context, state) {
                    if (state is QuoteAdding) {
                      Navigator.of(context).pop();
                      _dialogService.showStatusDialog(
                        title: 'Place Bid',
                        message: 'Sending...',
                      );
                    } else if (state is QuoteAddFailed) {
                      Navigator.of(context).pop();
                      _dialogService.showSuccessfulStatusDialog(
                          message: 'Sending failed!!');
                    } else if (state is QuoteAdded) {
                      Navigator.of(context).pop();
                      _dialogService.showSuccessfulStatusDialog(
                          message: 'Sent successfully!');
                      setState(() {
                        if (widget.job.bids == null)
                          widget.job.bids = null;
                        widget.job.bids.add(state.quote);
                      });
                    }
                  },
                  child: buildTradeAction(context),
                  //SizedBox(height: 5.0),
                ),
              ),
            ]
            ),
          ),
          BlocProvider(
            create: (context) => MessageBloc(
              messageRepository:
                  RepositoryProvider.of<MessageRepository>(context),
              appType: appType,
              authLocalDataSource: sl<AuthLocalDataSource>(),
            )..add(LoadJobMessagesEvent(jobId: widget.job.id)),
              child: BlocBuilder<MessageBloc, MessageState>(
                builder: (context, state) {
                  if (state is MessageInitial) {
                    return LoadingWidget();
                  } else if (state is JobMessageLoading) {
                    return LoadingWidget();
                  } else if (state is LoadJobMessageFailed) {
                    return ErrorWidget('Error $state');
                  } else if (state is JobMessageLoaded) {
                    return MessageBody(
                      messageBox: new MessageBox(
                        name: widget.job.title,
                        jobId: widget.job.id,
                        traderId: traderId,
                        clientId: widget.job.clientId,
                        senderId: appType == AppType.TRADER
                            ? traderId
                            : widget.job.clientId,
                        recipientId: appType == AppType.TRADER
                            ? widget.job.clientId
                            : traderId,
                      ),
                      messages: state.messages,
                    );
                  }
                  return ErrorWidget('Unhandle State $state');
                },
              //),
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage(BuildContext context) {
    int userId = 0;
    String photo = '';
    final appType = AppConfig.of(context).appType;
    try {
      if (appType == AppType.CLIENT) {
        ClientProfile clientProfile = sl<ClientProfile>();
        if (clientProfile != null) {
          userId = clientProfile.id;
          photo = clientProfile.photo;
        }
      } else {
        TraderProfile traderProfile = sl<TraderProfile>();
        if (traderProfile != null) {
          userId = traderProfile.id;
          photo = traderProfile.photo;
        }
      }
    } catch (e) {
      print(e.toString());
    }

    MessageBox messageBox = new MessageBox(
      name: widget.job.title,
      jobId: widget.job.id,
      traderId: traderId,
      clientId: widget.job.clientId,
      senderId: userId,
      recipientId: (appType == AppType.TRADER
          ? widget.job.clientId
          : traderId),
      image: photo,
    );
    AppRouter.pushPage(
      context,
      MessagesScreen(
        messageBox: messageBox,
      ),
    );
  }
}
