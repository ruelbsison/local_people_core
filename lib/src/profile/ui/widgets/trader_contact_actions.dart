import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/profile.dart';
import 'package:local_people_core/messages.dart';
import 'package:overlay_dialog/overlay_dialog.dart';
import 'package:local_people_core/quote.dart';

class TraderContactActions extends StatelessWidget {
  final TraderProfile profile;
  final ClientProfile otherProfile;
  TraderContactActions({
    Key key,
    @required this.profile,
    @required this.otherProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: (size.width - 10) / 2,
              //height: 36,
              padding: EdgeInsets.all(16.0),
              //padding: EdgeInsets.only(left: 12, top: 40),
              child: ElevatedButton(
                onPressed: () {
                  MessageBox msgBox = MessageBox(
                    name: otherProfile.fullName,
                    traderId: profile.id,
                    clientId: otherProfile.id,
                    image: otherProfile.photo,
                    senderId: otherProfile.id,
                    lastMessage:'',
                  );
                  AppRouter.pushPage(context,
                    MessagesScreen(messageBox: msgBox),);
                },
                child: Text(
                  LocalPeopleLocalizations.of(context)
                      .btnTitleSendMesssage,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.button.copyWith(color: Colors.white),
                ),
              ),
              //color: Colors.green,
            ),
          ),
        ),
        Expanded(
          child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: (size.width - 10) / 2,
                //height: 36,
                padding: EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(255, 99, 95, 1),
                    onPrimary: Color.fromRGBO(170, 186, 205, 1),
                  ),
                  onPressed: () {
                    _requestQuote(context);
                  },
                  child: Text(
                    'Request Quote',
                    //LocalPeopleLocalizations.of(context)
                    //    .btnTitleCancel,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.button.copyWith(color: Color.fromRGBO(255, 255, 255, 1),),
                  ),
                ),
              )),
        ),
      ],
    );
  }

  void _requestQuote(BuildContext context) {
    DialogService _dialogService = sl<DialogService>();
    _dialogService.showRequestQuoteDialog(traderId: profile.id);
    // DialogHelper().show(
    //     context,
    //     DialogWidget.custom(
    //       child: RequestQuoteWidget(),
    //     )
    // );
  }
}
