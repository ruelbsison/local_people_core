import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';
import '../../domain/entities/job.dart';
//import 'package:overlay_dialog/overlay_dialog.dart';
//import 'package:local_people_core/quote.dart';
import 'package:flutter_svg/flutter_svg.dart';

class JobBidActionsWidget extends StatelessWidget {
  final Job job;
  JobBidActionsWidget({
    Key key,
    @required this.job,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      //color: Colors.white,
      //margin: EdgeInsets.all(12.0),
      //padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(239, 244, 246, 1), width: 2),
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white),
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Flex(
                direction: Axis.horizontal,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 30.0),
                  Expanded(
                    flex: 7,
                    child: Text(
                      LocalPeopleLocalizations.of(context).titleJobBid,
                      textAlign: TextAlign.left,
                      style: theme.textTheme.bodyText1,
                    ),
                  ),
                  // Expanded(
                  //   flex: 2,
                  //   child: Text(
                  //     LocalPeopleLocalizations.of(context).titleDeleteJob,
                  //     textAlign: TextAlign.left,
                  //     style: theme.textTheme.subtitle2,
                  //   ),
                  // ),
                  Expanded(
                    flex: 1,
                    child: CircleAvatar(
                      backgroundColor: Color(0xbbd0d9),
                      radius: 16,
                      child: Center (
                        child: SvgPicture.asset(
                          'packages/local_people_core/assets/images/dis-approved.svg',
                          fit: BoxFit.contain,
                          height: 25,
                          width: 25,
                        ),
                      ),
                    ),
                  ),
                ]
            ),
          ),
          SizedBox(height: 30.0),
          Container(
              color: Colors.white,
              child: Flex(
                direction: Axis.horizontal,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Expanded(
                  //   flex: 1,
                  //   child: Container(
                  //     //padding: EdgeInsets.only(left: 12.0, right: 12.0),
                  //     child: ElevatedButton(
                  //       onPressed: () => _requestVisit(context),
                  //       child: Text(
                  //           LocalPeopleLocalizations.of(context)
                  //               .titleRequestVisit,
                  //         style: theme.textTheme.button.copyWith(color: Colors.white),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(width: 12.0),
                  Expanded(
                    flex: 1,
                    child: Container(
                      //padding: EdgeInsets.only(left: 12.0, right: 12.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(255, 99, 95, 1),
                          onPrimary: Color.fromRGBO(170, 186, 205, 1),
                        ),
                        onPressed: () => _placeBid(context),
                        child: Text(
                            LocalPeopleLocalizations.of(context)
                                .titlePlaceBid,
                          style: theme.textTheme.button.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          //SizedBox(height: 20.0),
        ],
      ),
    );
  }

  void _requestVisit(BuildContext context) {
    DialogService _dialogService = sl<DialogService>();
    // DialogHelper().show(
    //     context,
    //     DialogWidget.custom(
    //       child: RequestVisitWidget(),
    //     )
    // );
  }

  void _placeBid(BuildContext context) {
    DialogService _dialogService = sl<DialogService>();
    _dialogService.showPlaceBidDialog(job: job,);
    // DialogHelper().show(
    //     context,
    //     DialogWidget.custom(
    //       child: PlaceBidWidget(job: job,),
    //     )
    // );
  }
}