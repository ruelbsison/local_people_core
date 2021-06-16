import 'package:flutter/material.dart';
import '../injection_container.dart';
import 'dialog_service.dart';
//import 'package:overlay_dialog/overlay_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'status_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_people_core/quote.dart';
import 'package:local_people_core/jobs.dart';

class DialogManager extends StatefulWidget {
  final Widget child;
  DialogManager({Key key, this.child}) : super(key: key);

  @override
  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  DialogService _dialogService = sl<DialogService>();
  //AlertStyle alertStyle;

  @override
  void initState() {
    super.initState();

    //final theme = Theme.of(context);
    // alertStyle = AlertStyle(
    //     animationType: AnimationType.fromTop,
    //     isCloseButton: false,
    //     isOverlayTapDismiss: false,
    //     descStyle: TextStyle(fontWeight: FontWeight.bold),
    //     animationDuration: Duration(milliseconds: 400),
    //     alertBorder: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(10.0),
    //       side: BorderSide(
    //         color: Colors.grey,
    //       ),
    //     ),
    //     titleStyle: theme.textTheme.subtitle1,
    //     titleTextAlign: TextAlign.left,
    //     constraints: BoxConstraints.expand(width: 300),
    //     //First to chars "55" represents transparency of color
    //     overlayColor: Color(0x55000000),
    //     alertElevation: 0,
    //     alertAlignment: Alignment.topCenter);

    _dialogService.registerStatusDialogListener(_showStatusDialog);
    _dialogService.registerErrorStatusDialogListener(_showErrorStatusDialog);
    _dialogService.registerSuccessfulStatusDialogListener(_showSuccessfulStatusDialog);
    _dialogService.registerRequestQuoteDialogListener(_showRequestQuoteDialog);
    _dialogService.registerPlaceBidDialogListener(_showPlaceBidDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showJobAwardDialog(Job job) {
    final theme = Theme.of(context);
    Alert(
      style: AlertStyle (
        alertBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        backgroundColor: theme.primaryColor,
        titleTextAlign: TextAlign.left,
        alertPadding: EdgeInsets.all(12.0),
        isButtonVisible: false,
        buttonAreaPadding: EdgeInsets.all(8.0),
        titleStyle: theme.textTheme.bodyText1,
      ),
      context: context,
      title: 'Job Award',
      closeIcon: SvgPicture.asset(
        'packages/local_people_core/assets/images/minus.svg',
        height: 24,
        width: 24,
      ),
      content: JobAwardWidget(job: job,),
      buttons: [],
    ).show();
  }

  void _showJobCancelDialog(Job job) {
    final theme = Theme.of(context);
    Alert(
      style: AlertStyle (
        alertBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        backgroundColor: theme.primaryColor,
        titleTextAlign: TextAlign.left,
        alertPadding: EdgeInsets.all(12.0),
        isButtonVisible: false,
        buttonAreaPadding: EdgeInsets.all(8.0),
        titleStyle: theme.textTheme.bodyText1,
      ),
      context: context,
      title: 'Job Cancel',
      closeIcon: SvgPicture.asset(
        'packages/local_people_core/assets/images/minus.svg',
        height: 24,
        width: 24,
      ),
      content: JobCancelWidget(job: job,),
      buttons: [],
    ).show();
  }

  void _showJobUpdateDialog(Job job) {
    final theme = Theme.of(context);
    Alert(
      style: AlertStyle (
        alertBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        backgroundColor: theme.primaryColor,
        titleTextAlign: TextAlign.left,
        alertPadding: EdgeInsets.all(12.0),
        isButtonVisible: false,
        buttonAreaPadding: EdgeInsets.all(8.0),
        titleStyle: theme.textTheme.bodyText1,
      ),
      context: context,
      title: 'Job Update',
      closeIcon: SvgPicture.asset(
        'packages/local_people_core/assets/images/minus.svg',
        height: 24,
        width: 24,
      ),
      content: JobUpdateWidget(job: job,),
      buttons: [],
    ).show();
  }

  void _showJobChangeDialog(Job job) {
    final theme = Theme.of(context);
    Alert(
      style: AlertStyle (
        alertBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        backgroundColor: theme.primaryColor,
        titleTextAlign: TextAlign.left,
        alertPadding: EdgeInsets.all(12.0),
        isButtonVisible: false,
        buttonAreaPadding: EdgeInsets.all(8.0),
        titleStyle: theme.textTheme.bodyText1,
      ),
      context: context,
      title: 'Job Change',
      closeIcon: SvgPicture.asset(
        'packages/local_people_core/assets/images/minus.svg',
        height: 24,
        width: 24,
      ),
      content: JobChangeWidget(job: job,),
      buttons: [],
    ).show();
  }

  void _showPlaceBidDialog(Job job) {
    final theme = Theme.of(context);
    Alert(
      style: AlertStyle (
        alertBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        backgroundColor: theme.primaryColor,
        titleTextAlign: TextAlign.left,
        alertPadding: EdgeInsets.all(12.0),
        isButtonVisible: false,
        buttonAreaPadding: EdgeInsets.all(8.0),
        titleStyle: theme.textTheme.bodyText1,
      ),
      context: context,
      title: 'Place Bid',
      closeIcon: SvgPicture.asset(
        'packages/local_people_core/assets/images/minus.svg',
        height: 24,
        width: 24,
      ),
      content: PlaceBidWidget(job: job,),
      buttons: [],
    ).show();
  }

  void _showRequestQuoteDialog(int traderId) {
    final theme = Theme.of(context);
    Alert(
      style: AlertStyle (
        alertBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        backgroundColor: theme.primaryColor,
        titleTextAlign: TextAlign.left,
        alertPadding: EdgeInsets.all(12.0),
        isButtonVisible: false,
        buttonAreaPadding: EdgeInsets.all(8.0),
        titleStyle: theme.textTheme.bodyText1,
      ),
      context: context,
      title: 'Request Quote',
      type: AlertType.none,
      //closeFunction: _dialogService.requestQuoteDialogComplete(),
      closeIcon: SvgPicture.asset(
        'packages/local_people_core/assets/images/minus.svg',
        height: 24,
        width: 24,
      ),
      content: RequestQuoteWidget(traderId: traderId,),
      buttons: [],
    ).show();
  }

  void _showStatusDialog(StatusDialogRequest request) {
    final theme = Theme.of(context);
    Alert(
      //style: alertStyle,
        context: context,
        title: request.title,
        content: Column(
          children: <Widget>[
            SizedBox(height: 20.0,),
            Center (
              child: CircularProgressIndicator(),
            ),
            SizedBox(height: 10.0,),
            Center(
              child: Text(
                request.message,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyText1,
              ),
            ),
            SizedBox(height: 20.0,),
          ],
        ),
        buttons: [],
        ).show();
  }

  void _showErrorStatusDialog(String message) {
    final theme = Theme.of(context);
    Alert(
      //style: alertStyle,
      context: context,
      title: message, //'Error',
      type: AlertType.error,
      buttons: [
        DialogButton(
          child: Text(
            "Ok",
            style: theme.textTheme.button
          ),
          onPressed: () => _dialogService.errorStatusDialogComplete(),
        )
      ],
    ).show();
  }

  void _showSuccessfulStatusDialog(String message) {
    final theme = Theme.of(context);
    Alert(
      //style: alertStyle,
      context: context,
      title: message, //'Successful',
      type: AlertType.success,
      buttons: [
        DialogButton(
          child: Text(
              "Ok",
              style: theme.textTheme.button
          ),
          onPressed: () => _dialogService.successfulStatusDialogComplete(),
        )
      ],
    ).show();
  }
}

