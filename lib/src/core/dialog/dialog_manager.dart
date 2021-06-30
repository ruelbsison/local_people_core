import 'package:flutter/material.dart';
import '../injection_container.dart';
import 'dialog_service.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'status_dialog.dart';
import 'package:local_people_core/quote.dart';
import 'package:local_people_core/core.dart';
import 'package_create_dialog.dart';
import 'book_package_dialog.dart';
import 'package:local_people_core/jobs.dart';
import 'package:local_people_core/profile.dart';
import '../widgets/custom_alert.dart';
import 'dart:async';
import '../widgets/app_dialog.dart';
import 'place_bid_dialog.dart';
import 'job_dialog.dart';

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

    _dialogService.registerStatusDialogListener(_showStatusDialog);
    _dialogService.registerErrorStatusDialogListener(_showErrorStatusDialog);
    _dialogService
        .registerSuccessfulStatusDialogListener(_showSuccessfulStatusDialog);
    _dialogService.registerRequestQuoteDialogListener(_showRequestQuoteDialog);
    _dialogService.registerPlaceBidDialogListener(_showPlaceBidDialog);
    _dialogService.registerCreatePackageDialogListener(_showCreatePackageDialog);
    _dialogService.registerBookPackageDialogListener(_showBookPackageDialog);

    _dialogService.registerJobAwardDialogListener(_showJobAwardDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showPlaceBidDialog(PlaceBidRequest request) {
    showDialog(
      context: context,
      builder: (context) => AppDialog(
        title: 'Place Bid',
        child: PlaceBidWidget(
          job: request.job,
          traderId: request.traderId,
        ),
      ),
    );
  }

  void _showRequestQuoteDialog(int traderId) {
    showDialog(
      context: context,
      builder: (context) => AppDialog(
        title: 'Request Quote',
        child: QuoteRequestDetailWidget(
          traderId: traderId,
        ),
      ),
    );
  }

  void _showCreatePackageDialog(PackageCreateRequest request) {
    showDialog(
        context: context,
        builder: (context) => AppDialog(
          title: 'Create Package',
        child: PackageDetailWidget(
          name: request.packageName,
          traderId: request.traderId,
        ),
        ),
    );
  }

  void _showBookPackageDialog(BookPackageRequest request) {
    showDialog(
      context: context,
      builder: (context) => AppDialog(
        title: 'Book ' + request.package.name,
        child: BookPackageWidget(
          package: request.package,
          traderName: request.traderName,
        ),
      ),
    );
  }

  void _showJobAwardDialog(JobAwardRequest request) {
    showDialog(
      context: context,
      builder: (context) => AppDialog(
        title: 'Award Job',
        child: JobAwardWidget(
          jobName: request.jobName,
          traderName: request.traderName,
        ),
      ),
    );
  }

  void _showJobCancelDialog(Job job) {
    showDialog(
      context: context,
      builder: (context) => AppDialog(
        title: 'Cancel Job',
        child: JobCancelWidget(
          job: job,
        ),
      ),
    );
  }

  void _showJobUpdateDialog(Job job) {
    showDialog(
      context: context,
      builder: (context) => AppDialog(
        title: 'Change Job Details',
        child: JobUpdateWidget(
          job: job,
        ),
      ),
    );
  }

  void _showJobChangeDialog(Job job) {
    showDialog(
      context: context,
      builder: (context) => AppDialog(
        title: 'Change Job Details',
        child: JobChangeWidget(
          job: job,
        ),
      ),
    );
  }

  void _showStatusDialog(StatusDialogRequest request) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (context) => AppDialog(
        title: request.title,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(255, 99, 95, 1),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: Text(
                request.message,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyText1,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
    // Alert(
    //   style: AlertStyle(
    //     alertBorder:
    //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    //     backgroundColor: theme.primaryColor,
    //     titleTextAlign: TextAlign.left,
    //     alertPadding: EdgeInsets.all(12.0),
    //     isButtonVisible: false,
    //     buttonAreaPadding: EdgeInsets.all(8.0),
    //     titleStyle: theme.textTheme.bodyText1,
    //   ),
    //   context: context,
    //   title: request.title,
    //   content: Column(
    //     children: <Widget>[
    //       SizedBox(
    //         height: 20.0,
    //       ),
    //       Center(
    //         child: CircularProgressIndicator(),
    //       ),
    //       SizedBox(
    //         height: 10.0,
    //       ),
    //       Center(
    //         child: Text(
    //           request.message,
    //           textAlign: TextAlign.center,
    //           style: theme.textTheme.bodyText1,
    //         ),
    //       ),
    //       SizedBox(
    //         height: 20.0,
    //       ),
    //     ],
    //   ),
    // ).show();
  }

  void _showErrorStatusDialog(String message) {
    final theme = Theme.of(context);
    Timer _timer = Timer(Duration(seconds: 3), () {
      DialogService _dialogService = sl<DialogService>();
      _dialogService.errorStatusDialogComplete();
      Navigator.of(context).pop();
    });
    Alert(
      style: AlertStyle(
        alertBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        backgroundColor: theme.primaryColor,
        titleTextAlign: TextAlign.left,
        alertPadding: EdgeInsets.all(12.0),
        isButtonVisible: false,
        buttonAreaPadding: EdgeInsets.all(8.0),
        titleStyle: theme.textTheme.bodyText1,
      ),
      context: context,
      title: message, //'Error',
      type: AlertType.error,
    ).show();
  }

  void _showSuccessfulStatusDialog(String message) {
    final theme = Theme.of(context);
    Timer _timer = Timer(Duration(seconds: 3), () {
      DialogService _dialogService = sl<DialogService>();
      _dialogService.successfulStatusDialogComplete();
      Navigator.of(context).pop();
    });
    Alert(
      style: AlertStyle(
        alertBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        backgroundColor: theme.primaryColor,
        titleTextAlign: TextAlign.left,
        alertPadding: EdgeInsets.all(12.0),
        isButtonVisible: false,
        buttonAreaPadding: EdgeInsets.all(8.0),
        titleStyle: theme.textTheme.bodyText1,
      ),
      context: context,
      title: message, //'Successful',
      type: AlertType.success,
    ).show();
  }
}
