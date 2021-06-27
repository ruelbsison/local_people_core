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
    // return PreferredSize(
    //     preferredSize: widget.appBarPreferredSize,
    //     child: AppBar(
    //     titleSpacing: 0,
    //     centerTitle: false,
    //     //automaticallyImplyLeading: false,
    //     flexibleSpace: PreferredSize(
    //       preferredSize: Size(size.width, widget.appBarPreferredSize.height),
    //       child: Flex(
    //         direction: Axis.horizontal,
    //         mainAxisSize: MainAxisSize.max,
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           Flex(
    //             direction: Axis.vertical,
    //             mainAxisSize: MainAxisSize.max,
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               // Container(
    //               //   child: Align(
    //               //     alignment: Alignment.center,
    //               //     child: BackButton(),
    //               //   ),
    //               // ),
    //               Container(
    //                 child: ClipOval(
    //                   child: SvgPicture.asset(
    //                     'packages/local_people_core/assets/images/package-orange.svg',
    //                     fit: BoxFit.contain,
    //                     height: 37,
    //                     width: 37,
    //                   ),
    //                 ),
    //               ),
    //               Container(
    //                 child: Text(
    //                   widget.job.minutesLeft.toString() + ' hrs left',
    //                   textAlign: TextAlign.center,
    //                   style: theme.textTheme.overline,
    //                 ),
    //               ),
    //             ],
    //           ),
    //           Expanded(
    //             flex: 3,
    //             child: Column(
    //               mainAxisSize: MainAxisSize.max,
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               crossAxisAlignment: CrossAxisAlignment.stretch,
    //               children: [
    //                 Text(
    //                   widget.job.title != null
    //                       ? widget.job.title
    //                       : widget.job.description,
    //                   style: theme.textTheme.headline6,
    //                   maxLines: 2,
    //                 ),
    //               ],
    //             ),
    //           ),
    //       ],
    //       ),
    //     ),
    //     elevation: 0.0,
    //     bottom: TabBar(
    //       controller: _controller,
    //       //unselectedLabelColor: Color.fromRGBO(239, 244, 246, 1), //theme.primaryColor,
    //       indicatorSize: TabBarIndicatorSize.tab,
    //       //indicatorColor: Color.fromRGBO(239, 244, 246, 1),
    //       indicator: BoxDecoration(
    //           borderRadius: BorderRadius.circular(5),
    //           color: Color.fromRGBO(239, 244, 246, 1)),
    //       tabs: [
    //         Tab(
    //           child: Align(
    //             alignment: Alignment.center,
    //             child: Text(
    //               "DETAILS",
    //               style: theme.textTheme.bodyText2,
    //             ),
    //           ),
    //         ),
    //         Tab(
    //           child: Align(
    //             alignment: Alignment.center,
    //             child: Text(
    //               "MESSAGES",
    //               style: theme.textTheme.bodyText2,
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  Widget buildBody(BuildContext context) {
    final theme = Theme.of(context);
    final appType = AppConfig.of(context).appType;
    int traderId = 0;
    try {
      if (appType == AppType.TRADER) {
        TraderProfile traderProfile = sl<TraderProfile>();
        if (traderProfile != null) {
          traderId = traderProfile.id;
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return SafeArea(
      child: TabBarView(
        controller: _controller,
        children: <Widget>[
          //   SnappingSheet(
          //   // TODO: Add your content that is placed
          //   // behind the sheet. (Can be left empty)
          //   child: MyOwnPageContent(),
          //   grabbingHeight: 75,
          //   // TODO: Add your grabbing widget here,
          //   grabbing: MyOwnGrabbingWidget(),
          //   sheetBelow: SnappingSheetContent(
          //     draggable: true,
          //     // TODO: Add your sheet content here
          //     child: MyOwnSheetContent(),
          //   ),
          // ),
          // );
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
                  SizedBox(height: 10.0),
                  //PostedByWidget(profile: widget.profile),
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
                  SizedBox(height: 30.0),
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
                        }
                      },
                      child: JobBidActionsWidget(
                        job: widget.job,
                        traderId: traderId,
                      ),
                      //SizedBox(height: 5.0),
                    ),
                  ),
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
            )..add(LoadJobMessagesEvent(jobId: widget.job.id)),
            // child: BlocListener<MessageBloc, MessageState>(
            //   listenWhen: (previousState, state) {
            //     if (state is MessageSending) {
            //       return true;
            //     } else if (state is SendMessageFailed) {
            //       return true;
            //     } else if (state is MessageSent) {
            //       return true;
            //     }
            //     return false;
            //   },
            //   listener: (context, state) {
            //     if (state is MessageSending) {
            //       _dialogService.showStatusDialog(
            //         title: 'Message',
            //         message: 'Sending...',
            //       );
            //     } else if (state is SendMessageFailed) {
            //       Navigator.of(context).pop();
            //       _dialogService.showSuccessfulStatusDialog(
            //           message: 'Sending failed!!');
            //     } else if (state is MessageSent) {
            //       Navigator.of(context).pop();
            //       _dialogService.showSuccessfulStatusDialog(
            //           message: 'Sent successfully!');
            //     }
            //   },
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
                        traderId: widget.job.traderId,
                        clientId: widget.job.clientId,
                        senderId: appType == AppType.TRADER
                            ? widget.job.traderId
                            : widget.job.clientId,
                        recipientId: appType == AppType.TRADER
                            ? widget.job.clientId
                            : widget.job.traderId,
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
      traderId: widget.job.traderId,
      clientId: widget.job.clientId,
      senderId: userId,
      recipientId: (appType == AppType.TRADER
          ? widget.job.clientId
          : widget.job.traderId),
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
