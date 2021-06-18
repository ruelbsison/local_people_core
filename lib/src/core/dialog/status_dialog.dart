import 'package:flutter/widgets.dart';
enum StatusDialogStatus {
  SUCCESSFUL,
  FAILED
}

class StatusDialogRequest {
  final String title;
  final String message;

  StatusDialogRequest({
    @required this.title,
    @required this.message,
  });
}

class StatusDialogResponse {
  final StatusDialogStatus status;

  StatusDialogResponse({
    @required this.status,
  });
}