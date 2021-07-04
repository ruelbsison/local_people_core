import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_people_core/messages.dart';
import '../../domain/entities/job.dart';
import 'package:local_people_core/profile.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';

typedef OnJobAwardPressed = void Function(String message);

class JobActionsWidget extends StatefulWidget {
  JobActionsWidget({
    Key key,
    @required this.job,
    @required this.traderName,
    this.onJobAwardPressed,
  }) : super(key: key);

  final Job job;
  final String traderName;
  final OnJobAwardPressed onJobAwardPressed;

  @override
  _JobActionsWidgetState createState() => _JobActionsWidgetState();
}
class _JobActionsWidgetState extends State<JobActionsWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      // color: Colors.white,
      // padding: EdgeInsets.all(12.0),
      // margin: EdgeInsets.only(top: 12.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
          border: Border.all(color: Color.fromRGBO(239, 244, 246, 1), width: 2),
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white),
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 10.0),
          Container(
            color: Colors.white,
            child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //SizedBox(height: 30.0),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          LocalPeopleLocalizations.of(context).titleJobBid,
                          textAlign: TextAlign.left,
                          style: theme.textTheme.bodyText1,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          LocalPeopleLocalizations.of(context).titleDeleteBid,
                          textAlign: TextAlign.right,
                          style: theme.textTheme.overline,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Align(
                        alignment: Alignment.centerRight,
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
                    ),
                  ),
                ]),
          ),
          // Container(
          //   color: Colors.white,
          //   child: Flex(
          //       direction: Axis.horizontal,
          //       //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: <Widget>[
          //         Expanded(
          //           flex: 7,
          //           child: Text(
          //             LocalPeopleLocalizations.of(context).titleJobBid,
          //             textAlign: TextAlign.left,
          //             style: theme.textTheme.bodyText1,
          //           ),
          //         ),
          //         Expanded(
          //           flex: 2,
          //           child: Text(
          //             LocalPeopleLocalizations.of(context).titleDeleteJob,
          //             textAlign: TextAlign.right,
          //             style: theme.textTheme.subtitle2,
          //           ),
          //         ),
          //         Expanded(
          //           flex: 1,
          //           child: CircleAvatar(
          //             backgroundColor: Color(0xbbd0d9),
          //             radius: 16,
          //             child: Center (
          //               child: SvgPicture.asset(
          //                 'packages/local_people_core/assets/images/dis-approved.svg',
          //                 fit: BoxFit.contain,
          //                 height: 25,
          //                 width: 25,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ]
          //   ),
          // ),
          SizedBox(height: 20.0),
          Container(
              color: Colors.white,
              child: Flex(
                direction: Axis.horizontal,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding:
                      EdgeInsets.only(left: 12.0, right: 12.0),
                      child: ElevatedButton(
                        onPressed: () {_sendMessage(context);},
                        child: Text(
                            LocalPeopleLocalizations.of(context)
                                .btnTitleSendMesssage,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.button.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding:
                      EdgeInsets.only(left: 12.0, right: 12.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(255, 99, 95, 1),
                          onPrimary: Color.fromRGBO(170, 186, 205, 1),
                        ),
                        onPressed: () {_awardJob(context);},
                        child: Text(
                            LocalPeopleLocalizations.of(context)
                                .btnTitleAwardJob,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.button.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          //SizedBox(height: 10.0),
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
        if (clientProfile  != null) {
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
      recipientId: (appType == AppType.TRADER ? widget.job.clientId : widget.job.traderId),
      image: photo,
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MessagesScreen(messageBox: messageBox,),
      ),
    );
  }

  void _awardJob(BuildContext context) async {
    DialogService _dialogService = sl<DialogService>();
    JobAwardResponse response = await  _dialogService.showJobAwardDialog(
        jobName: widget.job.title != null
            ? widget.job.title
            : widget.job.tags != null && widget.job.tags.length > 0
            ? widget.job.tags[0].name : 'Job' + ' ' +
            (widget.job.location != null && widget.job.location.name != null
        ?  widget.job.location.name : widget.job.description),
        traderName: widget.traderName
    );
    if (response != null
        && response.status == JobAwardStatus.JOB_AWARD) {
      if (widget.onJobAwardPressed != null) {
        widget.onJobAwardPressed(response.optionalMessage);
      }
    }
  }
}