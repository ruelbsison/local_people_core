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

