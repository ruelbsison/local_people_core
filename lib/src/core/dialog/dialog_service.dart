import 'dart:async';
import 'status_dialog.dart';
import 'package_create_dialog.dart';
import 'book_package_dialog.dart';
import 'place_bid_dialog.dart';
import 'package:local_people_core/jobs.dart';
import 'package:local_people_core/quote.dart';
import 'job_dialog.dart';

class DialogService {
  // Function _showDialogListener;
  // Completer _dialogCompleter;
  //
  // /// Registers a callback function. Typically to show the dialog
  // void registerDialogListener(Function showDialogListener) {
  //   _showDialogListener = showDialogListener;
  // }
  //
  // /// Calls the dialog listener and returns a Future that will wait for dialogComplete.
  // Future showDialog() {
  //   _dialogCompleter = Completer();
  //   _showDialogListener('Job', 'Posting ...');
  //   return _dialogCompleter.future;
  // }
  //
  // /// Completes the _dialogCompleter to resume the Future's execution call
  // void dialogComplete() {
  //   _dialogCompleter.complete();
  //   _dialogCompleter = null;
  // }

  Function(StatusDialogRequest) _showStatusDialogListener;
  Completer<StatusDialogResponse> _dialogStatusCompleter;

  /// Registers a callback function. Typically to show the dialog
  void registerStatusDialogListener(Function(StatusDialogRequest) showStatusDialogListener) {
    _showStatusDialogListener = showStatusDialogListener;
  }

  Future<StatusDialogResponse> showStatusDialog({
    String title,
    String message,
  }) {
    _dialogStatusCompleter = Completer<StatusDialogResponse>();
    _showStatusDialogListener(StatusDialogRequest(
      title: title,
      message: message,
    ));
    return _dialogStatusCompleter.future;
  }

  /// Completes the _dialogCompleter to resume the Future's execution call
  void statusDialogComplete(StatusDialogResponse response) {
    if (_dialogStatusCompleter != null) {
      _dialogStatusCompleter.complete(response);
      _dialogStatusCompleter = null;
    }
  }

  /* --------------------------------------------------------------------------------------*/
  Function(String) _showErrorStatusDialogListener;
  Completer _dialogErrorStatusCompleter;

  /// Registers a callback function. Typically to show the dialog
  void registerErrorStatusDialogListener(Function(String) showErrorStatusDialogListener) {
    _showErrorStatusDialogListener = showErrorStatusDialogListener;
  }

  Future showErrorStatusDialog({
    String message,
  }) {
    _dialogErrorStatusCompleter = Completer();
    _showErrorStatusDialogListener(
      message,
    );
    return _dialogErrorStatusCompleter.future;
  }

  /// Completes the _dialogCompleter to resume the Future's execution call
  void errorStatusDialogComplete() {
    if (_dialogErrorStatusCompleter != null) {
      _dialogErrorStatusCompleter.complete();
      _dialogErrorStatusCompleter = null;
    }
  }

  /* --------------------------------------------------------------------------------------*/
  Function(String) _showSuccessfulStatusDialogListener;
  Completer _dialogSuccessfulStatusCompleter;

  /// Registers a callback function. Typically to show the dialog
  void registerSuccessfulStatusDialogListener(Function(String) showSuccessfulStatusDialogListener) {
    _showSuccessfulStatusDialogListener = showSuccessfulStatusDialogListener;
  }

  Future showSuccessfulStatusDialog({
    String message,
  }) {
    _dialogSuccessfulStatusCompleter = Completer();
    _showSuccessfulStatusDialogListener(
      message,
    );
    return _dialogSuccessfulStatusCompleter.future;
  }

  /// Completes the _dialogCompleter to resume the Future's execution call
  void successfulStatusDialogComplete() {
    if (_dialogSuccessfulStatusCompleter != null) {
      _dialogSuccessfulStatusCompleter.complete();
      _dialogSuccessfulStatusCompleter = null;
    }
  }

  /* --------------------------------------------------------------------------------------*/
  Function(int) _showRequestQuoteDialogListener;
  Completer _dialogRequestQuoteCompleter;

  /// Registers a callback function. Typically to show the dialog
  void registerRequestQuoteDialogListener(Function(int) showRequestQuoteDialogListener) {
    _showRequestQuoteDialogListener = showRequestQuoteDialogListener;
  }

  Future showRequestQuoteDialog({
    int traderId,
  }) {
    _dialogRequestQuoteCompleter = Completer();
    _showRequestQuoteDialogListener(
      traderId,
    );
    return _dialogRequestQuoteCompleter.future;
  }

  /// Completes the _dialogCompleter to resume the Future's execution call
  void requestQuoteDialogComplete() {
    if (_dialogRequestQuoteCompleter != null) {
      _dialogRequestQuoteCompleter.complete();
      _dialogRequestQuoteCompleter = null;
    }
  }

  /* --------------------------------------------------------------------------------------*/
  Function(PlaceBidRequest) _showPlaceBidDialogListener;
  Completer<PlaceBidResponse> _dialogPlaceBidCompleter;

  /// Registers a callback function. Typically to show the dialog
  void registerPlaceBidDialogListener(Function(PlaceBidRequest) showPlaceBidDialogListener) {
    _showPlaceBidDialogListener = showPlaceBidDialogListener;
  }

  Future showPlaceBidDialog({
    Job job,
    int traderId,
  }) {
    _dialogPlaceBidCompleter = Completer<PlaceBidResponse>();
    _showPlaceBidDialogListener(PlaceBidRequest(
      job: job,
      traderId: traderId,
    )

    );
    return _dialogPlaceBidCompleter.future;
  }

  /// Completes the _dialogCompleter to resume the Future's execution call
  void placeBidDialogComplete(PlaceBidResponse response) {
    if (_dialogPlaceBidCompleter != null) {
      _dialogPlaceBidCompleter.complete(response);
      _dialogPlaceBidCompleter = null;
    }
  }

  /* --------------------------------------------------------------------------------------*/
  Function(PackageCreateRequest) _showCreatePackageDialogListener;
  Completer<PackageCreateResponse> _dialogCreatePackageCompleter;

  /// Registers a callback function. Typically to show the dialog
  void registerCreatePackageDialogListener(Function(PackageCreateRequest) showCreatePackageDialogListener) {
    _showCreatePackageDialogListener = showCreatePackageDialogListener;
  }

  Future<PackageCreateResponse> showCreatePackageDialog({
    int traderId,
    String packageName,
  }) {
    _dialogCreatePackageCompleter = Completer<PackageCreateResponse>();
    _showCreatePackageDialogListener(PackageCreateRequest(
      traderId: traderId,
      packageName: packageName
    ));
    return _dialogCreatePackageCompleter.future;
  }

  /// Completes the _dialogCompleter to resume the Future's execution call
  void createPackageDialogComplete(PackageCreateResponse reponse) {
    if (_dialogCreatePackageCompleter != null) {
      _dialogCreatePackageCompleter.complete(reponse);
      _dialogCreatePackageCompleter = null;
    }
  }

  /* --------------------------------------------------------------------------------------*/
  Function(BookPackageRequest) _showBookPackageDialogListener;
  Completer<BookPackageResponse> _dialogBookPackageCompleter;

  /// Registers a callback function. Typically to show the dialog
  void registerBookPackageDialogListener(Function(BookPackageRequest) showBookPackageDialogListener) {
    _showBookPackageDialogListener = showBookPackageDialogListener;
  }

  Future<BookPackageResponse> showBookPackageDialog({
    Package package,
    String traderName,
  }) {
    _dialogBookPackageCompleter = Completer<BookPackageResponse>();
    _showBookPackageDialogListener(BookPackageRequest(
        package: package,
        traderName: traderName,
    ));
    return _dialogBookPackageCompleter.future;
  }

  /// Completes the _dialogCompleter to resume the Future's execution call
  void bookPackageDialogComplete(BookPackageResponse reponse) {
    if (_dialogBookPackageCompleter != null) {
      _dialogBookPackageCompleter.complete(reponse);
      _dialogBookPackageCompleter = null;
    }
  }

  /* --------------------------------------------------------------------------------------*/
  Function(JobAwardRequest) _showJobAwardDialogListener;
  Completer<JobAwardResponse> _jobAwardDialogCompleter;

  /// Registers a callback function. Typically to show the dialog
  void registerJobAwardDialogListener(Function(JobAwardRequest) showJobAwardDialogListener) {
    _showJobAwardDialogListener = showJobAwardDialogListener;
  }

  Future<JobAwardResponse> showJobAwardDialog({
    String jobName,
    String traderName,
  }) {
    _jobAwardDialogCompleter = Completer<JobAwardResponse>();
    _showJobAwardDialogListener(JobAwardRequest(
      jobName: jobName,
      traderName: traderName,
    ));
    return _jobAwardDialogCompleter.future;
  }

  /// Completes the _dialogCompleter to resume the Future's execution call
  void jobAwardDialogComplete(JobAwardResponse response) {
    if (_jobAwardDialogCompleter != null) {
      _jobAwardDialogCompleter.complete(response);
      _jobAwardDialogCompleter = null;
    }
  }
  

}