import 'package:flutter/material.dart';
import '../widgets/posted_by_widget.dart';
import '../../domain/entities/job.dart';
import '../widgets/job_view_widget.dart';
import '../blocs/job_form_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/profile.dart';
import 'package:local_people_core/auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import '../widgets/post_actions_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:overlay_dialog/overlay_dialog.dart';
import 'package:local_people_core/quote.dart';
import '../widgets/job_body_container.dart';

class JobPreviewScreen extends StatefulWidget {
  JobPreviewScreen({
    Key key,
    @required this.job,
    //@required this.profile,
  }) : super(key: key);

  final Job job;
  dynamic profile;

  @override
  _JobPreviewScreenState createState() => _JobPreviewScreenState();
}

class _JobPreviewScreenState extends State<JobPreviewScreen>
    with TickerProviderStateMixin {
  TabController _controller;
  int _tab = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _controller = TabController(length: 2, vsync: this);
    _controller.addListener(() {
      setState(() {
        //if (_controller.index == 1) {
        //context.read<JobBloc>().add(LoadJobs());
        //}
      });
    });

    //requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: buildAppBar(context),
      appBar: buildAppBar(context),
      //body: buildTabBody(context),
      //body: buildTabBody(context),
      body: buildBody(context),
      // body: BlocProvider.value(
      //   value: BlocProvider.of<JobFormBloc>(context),
      //   child: buildBody(),
      // ),
    );

    // //return buildBody(context);
  //   return Scaffold(
  //     appBar: buildAppBar(context),
  //     body: SnappingSheet(
  //       // TODO: Add your content that is placed
  //       // behind the sheet. (Can be left empty)
  //       child: buildBody(context),
  //       grabbingHeight: 140,
  //       grabbing: DefaultGrabbing(),
  //       sheetBelow: SnappingSheetContent(
  //         // Pass in the scroll controller here!
  //         //childScrollController: _myScrollController,
  //         draggable: true,
  //         // TODO: Add your sheet content here
  //         child: PostActionsWidget(job: widget.job,),
  //       ),
  //     ),
  //   );
   }

  Widget buildAppBar(BuildContext context) {
    //}BuildContext context) {
    final theme = Theme.of(context);
    final appType = AppConfig.of(context).appType;
    try {
      if (appType == AppType.CLIENT) {
        ClientProfile clientProfile = sl<ClientProfile>();
        if (clientProfile != null) {
          widget.profile = clientProfile;
          return buildAppBarContent(context);
        }
      } else {
        TraderProfile traderProfile = sl<TraderProfile>();
        if (traderProfile != null) {
          widget.profile = traderProfile;
          return buildAppBarContent(context);
        }
      }
    } catch(e) {
    }

    return BlocProvider(
      create: (context) => ProfileBloc(
        profileRepository: RepositoryProvider.of<ProfileRepository>(context),
        appType: appType,
        authLocalDataSource: sl<AuthLocalDataSource>(),
      )..add(ProfileGetEvent()),
      child: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        if (state is ClientProfileLoaded) {
          locatorAddClientProfile(state.profile);
          widget.profile = state.profile;
          return buildAppBarContent(context);
        } else if (state is ProfileNotLoaded) {
          return ErrorWidget(state.e.toString());
        } else {
          return LoadingWidget();
        }
      }),
    );
  }

  Widget buildAppBarContent(BuildContext context) {
    final theme = Theme.of(context);
    return LocalPeopleAppBarWidget(
      title: widget.job.title != null ? widget.job.title : widget.job.description,
      startrDateTime: widget.job.date,
      packageSvgAssetIcon: 'packages/local_people_core/assets/images/package-grey.svg',
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
    ); //
    // return AppBar(
    //   toolbarHeight: 220.0,
    //   centerTitle: false,
    //   titleSpacing: 0,
    //   title: Column(
    //     //padding: EdgeInsets.only(bottom: 12.0),
    //     //child: Flex(
    //     children: <Widget>[
    //       SizedBox(height: 60.0),
    //       Flex(
    //         direction: Axis.horizontal,
    //         mainAxisSize: MainAxisSize.max,
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: <Widget>[
    //           Expanded(
    //             flex: 1,
    //             child: Flex(
    //               direction: Axis.vertical,
    //               crossAxisAlignment: CrossAxisAlignment.stretch,
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               children: <Widget>[
    //                 CircleAvatar(
    //                   backgroundColor: Color.fromRGBO(255, 166, 0, 1),
    //                   radius: 15,
    //                   child: CachedNetworkImage(
    //                     imageUrl: widget.profile.photo,
    //                     placeholder: (context, url) => LoadingWidget(
    //                       isImage: true,
    //                     ),
    //                     errorWidget: (context, url, error) => Image.asset(
    //                       'packages/local_people_core/assets/images/local-people-logo.png',
    //                       fit: BoxFit.cover,
    //                     ),
    //                     fit: BoxFit.cover,
    //                   ),
    //                 ),
    //                 Text(
    //                   // (widget.job.minutesLeft / 60).toString() + ' hrs left',
    //                   //widget.job.minutesLeft.toString() + ' hrs left',
    //                   DateFormatUtil.getDateTimeDiff(
    //                       DateTime.now(), widget.job.date),
    //                   textAlign: TextAlign.center,
    //                   style: TextStyle(
    //                       color: Color.fromRGBO(0, 63, 92, 1),
    //                       fontSize: 10,
    //                       fontWeight: FontWeight.w500,
    //                       fontFamily: 'RedHatDisplay'),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Expanded(
    //             flex: 4,
    //             child: Flex(
    //               direction: Axis.vertical,
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               children: <Widget>[
    //                 //Expanded(
    //                 //  flex: 2,
    //                 //child: Text(
    //                 Text(
    //                   widget.job.title != null
    //                       ? widget.job.title
    //                       : widget.job.description,
    //                   textAlign: TextAlign.left,
    //                   style: theme.textTheme.headline6,
    //                 ),
    //                 //),
    //                 //Expanded(
    //                 //  flex: 1,
    //                 //child: Text(
    //                 Text(
    //                   (widget.profile.fullName != null
    //                       ? widget.profile.fullName
    //                       : 'Client Full Name'),
    //                   textAlign: TextAlign.left,
    //                   style: theme.textTheme.bodyText1,
    //                 ),
    //                 //),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    //   elevation: 0.0,
    //   bottom: TabBar(
    //     controller: _controller,
    //     //unselectedLabelColor: Color.fromRGBO(239, 244, 246, 1), //theme.primaryColor,
    //     indicatorSize: TabBarIndicatorSize.tab,
    //     //indicatorColor: Color.fromRGBO(239, 244, 246, 1),
    //     indicator: BoxDecoration(
    //         borderRadius: BorderRadius.circular(5),
    //         color: Color.fromRGBO(239, 244, 246, 1)),
    //     tabs: [
    //       Tab(
    //         child: Align(
    //           alignment: Alignment.center,
    //           child: Text(
    //             "DETAILS",
    //             style: theme.textTheme.bodyText2,
    //           ),
    //         ),
    //       ),
    //       Tab(
    //         child: Align(
    //           alignment: Alignment.center,
    //           child: Text(
    //             "BIDS",
    //             style: theme.textTheme.bodyText2,
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  void _showProgressDialog(DialogService _dialogService) async {
    StatusDialogResponse dialogResult = await _dialogService.showStatusDialog(
      title: 'Post Job',
      message: 'Job Posting...',
    );
    if (dialogResult.status == StatusDialogStatus.SUCCESSFUL) {
      //Future
      //    .delayed(Duration(seconds: 5))
      //    .then((_) => _dialogService.successfulStatusDialogComplete());
      await _dialogService.showSuccessfulStatusDialog(message: 'Job Posted Successfully!');
      Navigator.of(context).popUntil(ModalRoute.withName('/'));
    } else {
      //Future
      //    .delayed(Duration(seconds: 5))
      //    .then((_) => _dialogService.errorStatusDialogComplete());
      await _dialogService.showErrorStatusDialog(message: 'Job Post Failed!');
      Navigator.of(context).pop();
    }
  }
  
  Widget buildBody(BuildContext context) {
    //BuildContext context) {
    DialogService _dialogService = sl<DialogService>();
    return BlocProvider.value(
      value: BlocProvider.of<JobFormBloc>(context),
      child: BlocListener<JobFormBloc, JobFormState>(
        listener: (context, state) {
          if (state is JobFormPostCompleted) {
            _dialogService.statusDialogComplete(
                StatusDialogResponse(
                    status: StatusDialogStatus.SUCCESSFUL
                )
            );
          } else if (state is JobFormPostFailed){
            _dialogService.statusDialogComplete(
                StatusDialogResponse(
                    status: StatusDialogStatus.FAILED
                )
            );
          } else if (state is JobFormPosting){
            _showProgressDialog(_dialogService);
          }
        },
        child: buildTabBody(context),
      ),
    );
  }

  Widget buildTabBody(BuildContext context) {
    return SafeArea(
        //child: JobBodyContainer(
      child: TabBarView(
        controller: _controller,
        children: <Widget>[
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                JobViewWidget(
                  job: widget.job,
                ),
                //SizedBox(height: 10.0),
                //PostedByWidget(profile: widget.profile),
                PostedByWidget(clientId: widget.job.clientId),
                //SizedBox(height: 10.0),
                PostActionsWidget(job: widget.job,),
                //_jobPostActions(context),
                SizedBox(height: 10.0),
              ],
            ),
          ),
          QuoteBodyWidget(job:  widget.job),
        ],
      ),
      //  ),
    );
  }

  Widget _jobPostActions(BuildContext context) {
    final theme = Theme.of(context);
    // return JobBodyContainer(
    // child: Container(
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.all(20.0),
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Flex(direction: Axis.horizontal,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 7,
                    child: Text(
                      LocalPeopleLocalizations.of(context).menuTitlePostJob,
                      textAlign: TextAlign.left,
                      style: theme.textTheme.bodyText1,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      LocalPeopleLocalizations.of(context).titleDeleteJob,
                      textAlign: TextAlign.left,
                      style: theme.textTheme.subtitle2,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: CircleAvatar(
                      backgroundColor: Color(0xbbd0d9),
                      radius: 16,
                      child: Center(
                        child: SvgPicture.asset(
                          'packages/local_people_core/assets/images/dis-approved.svg',
                          fit: BoxFit.contain,
                          height: 25,
                          width: 25,
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
          SizedBox(height: 30.0),
        ],
      ),
    //),
    );
  }

//   Widget SuccessDialog(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Row(
//               mainAxisSize: MainAxisSize.max,
//               children: <Widget>[
//                 const Icon(Icons.info),
//                 const Flexible(
//                   child: Padding(
//                     padding: EdgeInsets.all(10),
//                     child: Text(
//                       'Job Posted Successfully!',
//                       softWrap: true,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             ElevatedButton(
//               child: const Text('OK'),
//               onPressed: () =>
//                   Navigator.of(context).popUntil(ModalRoute.withName('/')),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
}

/*class JobCancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<JobBloc, JobState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.status.isValidated
              ? () => context.read<JobFormBloc>().add(JobFormSave())
              : null,
          child: Text(
            LocalPeopleLocalizations.of(context)
                .btnTitleCancel,
            style: theme.textTheme.button,
          ),
        );
      },
    );
  }
}

class JobPostButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<JobFormBloc, JobFormState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.status.isValidated
              ? () => context.read<JobFormBloc>().add(JobFormPost())
              : null,
          child: Text(
            LocalPeopleLocalizations.of(context).btnTitlePost,
            style: theme.textTheme.button,
          ),
        );
      },
    );
  }
}*/
