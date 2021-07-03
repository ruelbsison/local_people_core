import 'package:flutter/widgets.dart';
//import 'package:local_people_core/core.dart';
import 'package:local_people_core/jobs.dart';

enum JobAwardStatus {
  JOB_AWARD,
  BID_TURN_DOWN
}

class JobAwardRequest {
  final String jobName;
  final String traderName;

  JobAwardRequest({
    @required this.jobName,
    @required this.traderName,
  });
}

class JobAwardResponse {
  JobAwardStatus status;
  String optionalMessage;

  JobAwardResponse({
    this.status,
    this.optionalMessage,
  });
}

class JobChangeRequest {
  final DateTime startDateTime;
  final int durationInHours;
  final double price;

  JobChangeRequest({
    @required this.startDateTime,
    @required this.durationInHours,
    @required this.price,
  });
}

class JobChangeResponse {
  final DateTime startDateTime;
  final int durationInHours;
  final double price;

  JobChangeResponse({
    @required this.startDateTime,
    @required this.durationInHours,
    @required this.price,
  });
}

