import 'dart:async';
import 'status_dialog.dart';
import 'package:local_people_core/jobs.dart';

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
    _dialogStatusCompleter.complete(response);
    _dialogStatusCompleter = null;
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
    _dialogErrorStatusCompleter.complete();
    _dialogErrorStatusCompleter = null;
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
    _dialogSuccessfulStatusCompleter.complete();
    _dialogSuccessfulStatusCompleter = null;
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
    _dialogRequestQuoteCompleter.complete();
    _dialogRequestQuoteCompleter = null;
  }

  /* --------------------------------------------------------------------------------------*/
  Function(Job) _showPlaceBidDialogListener;
  Completer _dialogPlaceBidCompleter;

  /// Registers a callback function. Typically to show the dialog
  void registerPlaceBidDialogListener(Function(Job) showPlaceBidDialogListener) {
    _showPlaceBidDialogListener = showPlaceBidDialogListener;
  }

  Future showPlaceBidDialog({
    Job job,
  }) {
    _dialogPlaceBidCompleter = Completer();
    _showPlaceBidDialogListener(
      job,
    );
    return _dialogPlaceBidCompleter.future;
  }

  /// Completes the _dialogCompleter to resume the Future's execution call
  void placeBidDialogComplete() {
    _dialogPlaceBidCompleter.complete();
    _dialogPlaceBidCompleter = null;
  }
}